Return-Path: <cygwin-patches-return-9824-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 111941 invoked by alias); 11 Nov 2019 10:05:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 111930 invoked by uid 89); 11 Nov 2019 10:05:00 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-5.3 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.1 spammy=rows, sk:environ, columns, screen
X-HELO: atfriesa01.ssi-schaefer.com
Received: from atfriesa01.ssi-schaefer.com (HELO atfriesa01.ssi-schaefer.com) (193.186.16.100) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 11 Nov 2019 10:04:58 +0000
Received: from samail03.wamas.com (HELO mailhost.salomon.at) ([172.28.33.235])  by atfriesa01.ssi-schaefer.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Nov 2019 11:04:55 +0100
Received: from [172.28.42.244]	by mailhost.salomon.at with esmtp (Exim 4.77)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1iU6Z4-0006sJ-Ub; Mon, 11 Nov 2019 11:04:54 +0100
Subject: Re: [PATCH] Cygwin: pty: Disable clear screen for ssh sessions with -t option.
To: cygwin-patches@cygwin.com
References: <20191022182405.0ce3d7c17b0e7d924430b89c@nifty.ne.jp> <20191022134048.GP16240@calimero.vinschen.de> <20191023122717.66d241bd0a7814b7216d78f5@nifty.ne.jp> <20191023120542.GA16240@calimero.vinschen.de> <20191024100130.4c7f6e4ac55c10143e3c86f6@nifty.ne.jp> <20191024093817.GD16240@calimero.vinschen.de> <20191024191724.f44a44745f16f78595ae1b43@nifty.ne.jp> <20191024133305.GF16240@calimero.vinschen.de> <20191108110955.GC3372@calimero.vinschen.de> <20191108224232.c58ba683250a438a44e15e56@nifty.ne.jp> <20191111091755.GF3372@calimero.vinschen.de>
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Openpgp: preference=signencrypt
Message-ID: <fa81169e-c539-dbde-bdac-61d7b22ae842@ssi-schaefer.com>
Date: Mon, 11 Nov 2019 10:05:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191111091755.GF3372@calimero.vinschen.de>
Content-Type: multipart/mixed; boundary="------------409E1C39A886ACE344B0C0A9"
X-SW-Source: 2019-q4/txt/msg00095.txt.bz2

This is a multi-part message in MIME format.
--------------409E1C39A886ACE344B0C0A9
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-length: 785

Hi Takashi,

On 11/11/19 10:17 AM, Corinna Vinschen wrote:
> On Nov  8 22:42, Takashi Yano wrote:

>> I came up with another alternative. How about the attached
>> patch? This forcibly redraws screen when the first native
>> program is executed after creating new pty (pseudo console),
>> instead of clearing screen.
>>
>> This does not solve missing screen contents, but can avoid
>> cursor position problem in netsh.
> 
> I tested it and I think this is a great step forward.  Dropping
> $TERM checks and clear screen sequence is the way to go!

I second that!

Your "when the first native program is executed" does lead me to my
next test case with native programs involved, which seems to work
as expected with your patch applied on top of commit d14714c69.

Thanks a lot!
/haubi/

--------------409E1C39A886ACE344B0C0A9
Content-Type: text/x-python;
 name="ptytest3.py"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="ptytest3.py"
Content-length: 2960

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
    proc = subprocess.Popen(['/bin/stty', 'size'],
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
  pid = os.fork()
  if pid == 0:
    cmd = ['/bin/stty', 'rows', str(lines), 'columns', str(columns)]
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
  os.execv("/bin/sh", ["/bin/sh","-c", '''
      { cmd /c "set COLUMNS & set LINES & set TERM" ;
        "$(/usr/bin/cygpath -F 42)/Microsoft Visual Studio/Installer/vswhere.exe" -nologo -latest -legacy -format text -property installationPath ;
      } 2>&1 | /bin/tr -d \\\\r
    '''])
  sys.exit(0)

os.close(slavefd)

while True:
  (rlist, wlist, xlist) = select.select([masterfd], [], [masterfd], 100)
  if rlist:
    try:
      line = os.read(rlist[0], 1024)
      print(line,)
    except OSError as e:
      if (e.errno != 5):
        print("quit:",e)
      break
sys.exit(0)

--------------409E1C39A886ACE344B0C0A9--
