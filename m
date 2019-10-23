Return-Path: <cygwin-patches-return-9791-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 60881 invoked by alias); 23 Oct 2019 13:20:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 60870 invoked by uid 89); 23 Oct 2019 13:20:04 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,SPF_FAIL autolearn=no version=3.3.1 spammy=H*r:envelope-sender, H*r:encrypted, sk:environ, H*r:network
X-HELO: smtpout.aon.at
Received: from smtpout.aon.at (HELO smtpout.aon.at) (195.3.96.89) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 23 Oct 2019 13:20:01 +0000
Received: (qmail 5776 invoked from network); 23 Oct 2019 13:19:56 -0000
Received: from 80-121-140-134.adsl.highway.telekom.at (HELO [10.0.0.1]) ([80.121.140.134])          (envelope-sender <michael.haubenwallner@ssi-schaefer.com>)          by smarthub83.res.a1.net (qmail-ldap-1.03) with AES256-SHA encrypted SMTP; 23 Oct 2019 13:19:55 -0000
X-A1Mail-Track-Id: 1571836795:5761:smarthub83:80.121.140.134:1
Subject: Re: [PATCH] Cygwin: pty: Disable clear screen for ssh sessions with -t option.
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
To: cygwin-patches@cygwin.com
Newsgroups: gmane.os.cygwin.patches
References: <20191018113721.2486-1-takashi.yano@nifty.ne.jp> <b13f5d3c-c557-ff4e-6fcd-399952bad47e@ssi-schaefer.com> <20191022080402.GO16240@calimero.vinschen.de> <40c9d2ad-24a5-400a-abd4-af4235b83e2a@ssi-schaefer.com>
Message-ID: <cd4403b5-e77a-5ace-6b5e-a8d2a21d72a1@ssi-schaefer.com>
Date: Wed, 23 Oct 2019 13:20:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <40c9d2ad-24a5-400a-abd4-af4235b83e2a@ssi-schaefer.com>
Content-Type: multipart/mixed; boundary="------------A432D2A6A4473C7E9DBE9751"
X-SW-Source: 2019-q4/txt/msg00062.txt.bz2

This is a multi-part message in MIME format.
--------------A432D2A6A4473C7E9DBE9751
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-length: 1431

On 10/22/19 12:06 PM, Michael Haubenwallner wrote:
> On 10/22/19 10:04 AM, Corinna Vinschen wrote:
>> On Oct 22 09:20, Michael Haubenwallner wrote:
>>> On 10/18/19 1:37 PM, Takashi Yano wrote:
> 
>>>> +      const char *term = getenv ("TERM");
>>>> +      if (term && strcmp (term, "dumb") && !strstr (term, "emacs") &&
>>>> +	  wcsstr (myself->progname, L"\\usr\\sbin\\sshd.exe"))
> 
>>> Again, my real problem does not utilize ssh at all, but is some python script
>>> using multiple pty.openpty() to spawn commands inside, to allow for herding
>>> all the subprocesses started by the commands (Ctrl-C or similar).
> 
>> In terms of clearing the screen at all, what's your opinion, Michael?
> 
> While I do not fully understand TTY handling, clearing the screen because
> just opening a PTY doesn't feel correct.
> 
> To start with, attached is some python script where I do not expect to see
> the initial clear screen code, but the one from /usr/bin/clear only.
> 

> Interesting enough, cygwin-3.0.7 does dump core somewhere in between, so the real
> python program probably does some additional setup I've not extracted yet.

Sorry, the issue with cygwin-3.0.7 probably was because I've built my python3
against cygwin-3.1. Using Cygwin python 2 or 3 it does work with cygwin-3.0.7.

Here's an improved version, with additional initialization found in the real
world program - doesn't make a significant difference.

/haubi/

--------------A432D2A6A4473C7E9DBE9751
Content-Type: text/x-python;
 name="ptytest2.py"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="ptytest2.py"
Content-length: 2826

#! /usr/bin/env python

import pty
import os
import select
import subprocess
import sys
import termios

if sys.hexversion >= 0x3000000:

  def _unicode_encode(s, encoding='utf_8', errors='backslashreplace'):
    if isinstance(s, str):
      s = s.encode(encoding, errors)
    return s

  def _unicode_decode(s, encoding='utf_8', errors='replace'):
    if isinstance(s, bytes):
      s = str(s, encoding=encoding, errors=errors)
    return s

  _native_string = _unicode_decode

else:

  def _unicode_encode(s, encoding='utf_8', errors='backslashreplace'):
    if isinstance(s, unicode):
      s = s.encode(encoding, errors)
    return s

  def _unicode_decode(s, encoding='utf_8', errors='replace'):
    if isinstance(s, bytes):
      s = unicode(s, encoding=encoding, errors=errors)
    return s

  _native_string = _unicode_encode

def get_term_size(fd=None):
  if fd is None:
    fd = sys.stdout
  if not hasattr(fd, 'isatty') or not fd.isatty():
    return (0, 0)
  try:
    import curses
    try:
      curses.setupterm(term=os.environ.get("TERM", "unknown"), fd=fd.fileno())
      return curses.tigetnum('lines'), curses.tigetnum('cols')
    except curses.error:
      pass
  except ImportError:
    pass
  try:
    proc = subprocess.Popen(['stty', 'size'],
        stdout=subprocess.PIPE, stderr=fd)
  except EnvironmentError as e:
    if e.errno != errno.ENOENT:
      raise
    # stty command not found
    return (0, 0)

  out = _unicode_decode(proc.communicate()[0])
  if proc.wait() == os.EX_OK:
    out = out.split()
    if len(out) == 2:
      try:
        val = (int(out[0]), int(out[1]))
      except ValueError:
        raise
      else:
        if val[0] >= 0 and val[1] >= 0:
          return val
  return (0, 0)

def set_term_size(lines, columns, fd):
  print("set_term_size(lines:",lines,", columns:",columns,", fd:",fd)
  pid = os.fork()
  if pid == 0:
    cmd = ['stty', 'rows', str(lines), 'columns', str(columns)]
    os.dup2(0, fd)
    os.execvp(cmd[0], cmd)
    print("set_term_size failed")
    os.exit(1)
  ret = os.waitpid(pid, 0)
  return ret

(masterfd, slavefd) = pty.openpty()

mode = termios.tcgetattr(slavefd)
mode[1] &= ~termios.OPOST
termios.tcsetattr(slavefd, termios.TCSANOW, mode)

if sys.stdout.isatty():
  rows, columns = get_term_size(sys.stdout)
  set_term_size(rows, columns, slavefd)

if os.fork() == 0:
  os.close(masterfd)
  os.dup2(slavefd, 0)
  os.dup2(slavefd, 1)
  os.dup2(slavefd, 2)
  os.execv("/bin/sh", ["/bin/sh","-c","/bin/pwd;/usr/bin/clear"])
  sys.exit(0)

os.close(slavefd)

while True:
  (rlist, wlist, xlist) = select.select([masterfd], [], [masterfd], 100)
  print("select read:",rlist,"except:",xlist)
  if rlist:
    try:
      line = os.read(rlist[0], 1024)
      print("read:", line)
    except OSError as e:
      print("quit:",e)
      break
sys.exit(0)

--------------A432D2A6A4473C7E9DBE9751--
