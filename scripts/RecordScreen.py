#!/usr/bin/env python

# This version automatically adjusts settings for Ubuntu 11.10 and 12.04 to avoid having
# different versions of the script. Inspired by code and comments found at
# http://www.davidrevoy.com/article65/recordscreen-py-video-and-audio-capture-for-linux-with-ffmpeg
# Changes by Abe Pazos on May 16th, 2012 at 1:15pm.

""" A simple screen-capture utility.  Utilizes ffmpeg or avconv with h264 support.
By default it captures the entire desktop.
"""

################################ LICENSE BLOCK ################################
# Copyright (c) 2011 Nathan Vegdahl
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
###############################################################################

import os
import sys
import os.path
import glob
import time
import random
import tempfile
import optparse
import subprocess
import re
import platform


PYTHON_3 = (sys.version_info[0] == 3)


try:
  OS_VERSION = platform.linux_distribution()
except:
  OS_VERSION = (0, 0, 0)


# Easy-to-change defaults for users
DEFAULT_FPS = 15
DEFAULT_CAPTURE_AUDIO_DEVICE = "pulse"
DEFAULT_CAPTURE_DISPLAY_DEVICE = ":0.0"
DEFAULT_FILE_EXTENSION = "mkv"
DEFAULT_VIDEO_CODEC = "h264_fast"

if OS_VERSION[0] == 'Ubuntu' and OS_VERSION[1] == '12.04':
  ACCEPTABLE_FILE_EXTENSIONS = ["avi", "mp4", "mov", "mkv", "ogv"]
  DEFAULT_AUDIO_CODEC = "vorbis"
  APP = 'avconv'
elif OS_VERSION[0] == 'Ubuntu' and OS_VERSION[1] == '11.10':
  ACCEPTABLE_FILE_EXTENSIONS = ["avi", "mp4", "mov", "mkv", "ogv"]
  DEFAULT_AUDIO_CODEC = "vorbis"
  APP = 'ffmpeg'
else:
  ACCEPTABLE_FILE_EXTENSIONS = ["avi", "mp4", "mov", "mkv", "ogv", "webm"]
  DEFAULT_AUDIO_CODEC = "pcm"
  APP = 'ffmpeg'


# Optional packages
try:
    import Tkinter
    have_tk = True
except ImportError:
    have_tk = False

try:
    import multiprocessing
    have_multiproc = True
except ImportError:
    have_multiproc = False


# Video codec lines
vcodecs = {}

# Audio codec lines
acodecs = {}
acodecs["pcm"] = ["-acodec", "pcm_s16le"]
#acodecs["flac"] = ["-acodec", "flac"]

if OS_VERSION[0] == 'Ubuntu' and (OS_VERSION[1] == '12.04' or OS_VERSION[1] == '11.10'):
  vcodecs["mpeg4"] = ["-vcodec", "mpeg4", "-qmax", "1", "-qmin", "1"]
  vcodecs["huffyuv"] = ["-vcodec", "huffyuv"]
  vcodecs["vp8"] = ["-vcodec", "libvpx", "-qmax", "2", "-qmin", "1"]
  vcodecs["theora"] = ["-vcodec", "libtheora", "-b", "40000kb"]
  #vcodecs["xvid"] = ["-vcodec", "libxvid", "-b", "40000kb"]
  #vcodecs["dirac"] = ["-vcodec", "libschroedinger", "-b", "40000kb"]
  if OS_VERSION[1] == '12.04':
    vcodecs["h264"] = ["-vcodec", "libx264", "-preset", "medium", "-cqp", "0"]
    vcodecs["h264_fast"] = ["-vcodec", "libx264", "-preset", "ultrafast", "-g", "15", "-crf", "0", "-pix_fmt", "yuv444p"]
  else:
    vcodecs["h264"] = ["-vcodec", "libx264", "-vpre", "lossless_medium"]
    vcodecs["h264_fast"] = ["-vcodec", "libx264", "-vpre", "lossless_ultrafast"]

  acodecs["vorbis"] = ["-acodec", "libvorbis", "-ab", "320k"]
  acodecs["mp3"] = ["-acodec", "libmp3lame", "-ab", "320k"]
  acodecs["aac"] = ["-acodec", "libfaac", "-ab", "320k"]

else:
  vcodecs["h264"] = ["-vcodec", "libx264", "-vprofile", "baseline", "-preset", "ultrafast", "-g", "15", "-crf", "1", "-pix_fmt", "yuv420p"]
  vcodecs["h264_fast"] = ["-vcodec", "libx264", "-preset", "ultrafast", "-g", "15", "-crf", "0", "-pix_fmt", "yuv444p"]
  vcodecs["mpeg4"] = ["-vcodec", "mpeg4", "-g", "15", "-qmax", "1", "-qmin", "1"]
  vcodecs["huffyuv"] = ["-vcodec", "huffyuv"]
  vcodecs["vp8"] = ["-vcodec", "libvpx", "-g", "15", "-qmax", "1", "-qmin", "1"]
  vcodecs["theora"] = ["-vcodec", "libtheora", "-g", "15", "-b:v", "40000k"]
  #vcodecs["xvid"] = ["-vcodec", "libxvid", "-g", "15", "-b:v", "40000k"]
  #vcodecs["dirac"] = ["-vcodec", "libschroedinger", "-g", "15", "-b:v", "40000k"]

  acodecs["vorbis"] = ["-acodec", "libvorbis", "-b:a", "320k"]
  acodecs["mp3"] = ["-acodec", "libmp3lame", "-b:a", "320k"]
  acodecs["aac"] = ["-acodec", "libfaac", "-b:a", "320k"]


def capture_line(fps, x, y, height, width, display_device, audio_device, video_codec, audio_codec, output_path):
    """ Returns the command line to capture video+audio, in a list form
        compatible with Popen.
    """
    threads = 2
    if have_multiproc:
        # Detect the number of threads we have available
        threads = multiprocessing.cpu_count()
    line = [APP,
            "-f", "alsa",
            "-ac", "2",
            "-i", str(audio_device),
            "-f", "x11grab",
            "-r", str(fps),
            "-s", "%dx%d" % (int(height), int(width)),
            "-i", display_device + "+" + str(x) + "," + str(y)]
    line += acodecs[audio_codec]
    line += vcodecs[video_codec]
    line += ["-threads", str(threads), str(output_path)]
    return line


def video_capture_line(fps, x, y, height, width, display_device, video_codec, output_path):
    """ Returns the command line to capture video (no audio), in a list form
        compatible with Popen.
    """
    threads = 2
    if have_multiproc:
        # Detect the number of threads we have available
        threads = multiprocessing.cpu_count()

    line = [APP,
            "-f", "x11grab",
            "-r", str(fps),
            "-s", "%dx%d" % (int(height), int(width)),
            "-i", display_device + "+" + str(x) + "," + str(y)]
    line += vcodecs[video_codec]
    line += ["-threads", str(threads), str(output_path)]
    return line


def audio_capture_line(audio_device, audio_codec, output_path):
    """ Returns the command line to capture audio (no video), in a list form
        compatible with Popen.
    """
    line = [APP,
            "-f", "alsa",
            "-ac", "2",
            "-i", str(audio_device)]
    line += acodecs[audio_codec]
    line += [str(output_path)]
    return line


def get_desktop_resolution():
    """ Returns the resolution of the desktop as a tuple.
    """
    if have_tk:
        # Use tk to get the desktop resolution if we have it
        root = Tkinter.Tk()
        width = root.winfo_screenwidth()
        height = root.winfo_screenheight()
        root.destroy()
        return (width, height)
    else:
        # Otherwise call xdpyinfo and parse its output
        try:
            proc = subprocess.Popen("xdpyinfo", stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        except OSError:
            return None
        out, err = proc.communicate()
        if PYTHON_3:
            lines = str(out).split("\\n")
        else:
            lines = out.split("\n")
        for line in lines:
            if "dimensions" in line:
                line = re.sub(".*dimensions:[ ]*", "", line)
                line = re.sub("[ ]*pixels.*", "", line)
                wh = line.strip().split("x")
                return (int(wh[0]), int(wh[1]))


def get_window_position_and_size():
    """ Prompts the user to click on a window, and returns the window's
        position and size.
    """
    try:
        proc = subprocess.Popen("xwininfo", stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    except OSError:
        return None
    out, err = proc.communicate()
    if PYTHON_3:
        lines = str(out).split("\\n")
    else:
        lines = out.split("\n")
    x = 0
    y = 0
    w = 0
    h = 0
    xt = False
    yt = False
    wt = False
    ht = False
    for line in lines:
        if "Absolute upper-left X:" in line:
            x = int(re.sub("[^0-9]", "", line))
            xt = True
        elif "Absolute upper-left Y:" in line:
            y = int(re.sub("[^0-9]", "", line))
            yt = True
        elif "Width:" in line:
            w = int(re.sub("[^0-9]", "", line))
            wt = True
        elif "Height:" in line:
            h = int(re.sub("[^0-9]", "", line))
            ht = True
    if xt and yt and wt and ht:
        return (x, y, w, h)
    else:
        return None


def get_default_output_path():
    """ Creates a default output file path.
        Pattern: out_####.ext
    """
    filenames = glob.glob("out_????" + "." + DEFAULT_FILE_EXTENSION)
    for i in range(1, 9999):
        name = "out_" + str(i).rjust(4,'0') + "." + DEFAULT_FILE_EXTENSION
        tally = 0
        for f in filenames:
            if f == name:
                tally += 1
        if tally == 0:
            return name
    return "out_9999" + "." + DEFAULT_FILE_EXTENSION


def print_codecs():
    """ Prints a list of the available audio/video codecs.
    """
    a = []
    v = []
    for i in acodecs:
        a += [i]
    for i in vcodecs:
        v += [i]
    a.sort()
    v.sort()

    print("Audio codecs:")
    for i in a:
        print("  " + str(i))

    print("Video codecs:")
    for i in vcodecs:
        print("  " + str(i))

if __name__ == "__main__":
    # Set up default file path
    out_path = get_default_output_path()

    # Parse command line arguments
    parser = optparse.OptionParser(usage="%prog [options] [output_file" + "." + DEFAULT_FILE_EXTENSION + "]")
    parser.add_option("-w", "--capture-window", action="store_true", dest="capture_window",
                      default=False,
                      help="prompt user to click on a window to capture")
    parser.add_option("-n", "--no-audio", action="store_true", dest="no_audio",
                      default=False,
                      help="don't capture audio")
    parser.add_option("-r", "--fps", dest="fps",
                      type="int", default=DEFAULT_FPS,
                      help="frame rate to capture video at. Default: " + str(DEFAULT_FPS))
    parser.add_option("-p", "--position", dest="xy", metavar="XxY",
                      type="string", default=None,
                      help="upper left corner of the capture area (in pixels from the upper left of the screen). Default: 0x0")
    parser.add_option("-s", "--size", dest="size",
                      type="string", default=None, metavar="WIDTHxHEIGHT",
                      help="resolution of the capture area (in pixels). Default: entire desktop")
    parser.add_option("--crop-top", dest="crop_top",
                      type="int", default=0,
                      help="number of pixels to crop off the top of the capture area")
    parser.add_option("--crop-bottom", dest="crop_bottom",
                      type="int", default=0,
                      help="number of pixels to crop off the bottom of the capture area")
    parser.add_option("--crop-left", dest="crop_left",
                      type="int", default=0,
                      help="number of pixels to crop off the left of the capture area")
    parser.add_option("--crop-right", dest="crop_right",
                      type="int", default=0,
                      help="number of pixels to crop off the right of the capture area")
    parser.add_option("-a", "--audio-device", dest="audio_device",
                      default=DEFAULT_CAPTURE_AUDIO_DEVICE,
                      help="the audio device to capture from (eg. hw:0).  Default: " + DEFAULT_CAPTURE_AUDIO_DEVICE)
    parser.add_option("-d", "--display-device", dest="display_device",
                      default=DEFAULT_CAPTURE_DISPLAY_DEVICE,
                      help="the display device to capture from (eg. :0.0).  Default: " + DEFAULT_CAPTURE_DISPLAY_DEVICE)
    parser.add_option("--acodec", dest="acodec",
                      default=DEFAULT_AUDIO_CODEC,
                      help="the audio codec to encode with.  Default: " + DEFAULT_AUDIO_CODEC)
    parser.add_option("--vcodec", dest="vcodec",
                      default=DEFAULT_VIDEO_CODEC,
                      help="the video codec to encode with.  Default: " + DEFAULT_VIDEO_CODEC)
    parser.add_option("--codecs", action="store_true", dest="list_codecs",
                      default=False,
                      help="display the available audio and video codecs")

    opts, args = parser.parse_args()

    # Print list of codecs, if requested
    if opts.list_codecs:
        print_codecs()
        exit(0)

    # Output file path
    if len(args) >= 1:
        out_path = args[0]
        exts = out_path.rsplit(".", 1)

        if len(exts) == 1 or exts[1] not in ACCEPTABLE_FILE_EXTENSIONS:
            out_path += "." + DEFAULT_FILE_EXTENSION

    # Get desktop resolution
    try:
        dres = get_desktop_resolution()
    except:
        print("Error: unable to determine desktop resolution.")
        raise

    # Capture values
    fps = opts.fps
    if opts.capture_window:
        print("Please click on a window to capture.")
        x, y, width, height = get_window_position_and_size()
    else:
        if opts.xy:
            if re.match("^[0-9]*x[0-9]*$", opts.xy.strip()):
                xy = opts.xy.strip().split("x")
                x = int(xy[0])
                y = int(xy[1])
            else:
                raise parser.error("position option must be of form XxY (e.g. 50x64)")
        else:
            x = 0
            y = 0

        if opts.size:
            if re.match("^[0-9]*x[0-9]*$", opts.size.strip()):
                size = opts.size.strip().split("x")
                width = int(size[0])
                height = int(size[1])
            else:
                raise parser.error("size option must be of form HxW (e.g. 1280x720)")
        else:
            width = dres[0]
            height = dres[1]

    # Calculate cropping
    width -= opts.crop_left + opts.crop_right
    height -= opts.crop_top + opts.crop_bottom
    x += opts.crop_left
    y += opts.crop_top

    # Make sure the capture resolution conforms to the restrictions
    # of the video codec.  Crop to conform, if necessary.
    mults = {"h264": 2, "h264_fast": 2, "mpeg4": 2, "dirac": 2, "xvid": 2, "theora": 8, "huffyuv": 2, "vp8": 1}
    width -= width % mults[opts.vcodec]
    height -= height % mults[opts.vcodec]

    # Verify that capture area is on screen
    if (x + width) > dres[0] or (y + height) > dres[1]:
        parser.error("specified capture area is off screen.")

    # Capture!
    if not opts.no_audio:
        proc = subprocess.Popen(capture_line(fps, x, y, width, height, opts.display_device, opts.audio_device, opts.vcodec, opts.acodec, out_path)).wait()
    else:
        proc = subprocess.Popen(video_capture_line(fps, x, y, width, height, opts.display_device, opts.vcodec, out_path)).wait()

    print("Done!")

