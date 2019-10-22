Return-Path: <cygwin-patches-return-9783-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 80541 invoked by alias); 22 Oct 2019 10:06:46 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 80531 invoked by uid 89); 22 Oct 2019 10:06:45 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-5.3 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.1 spammy=
X-HELO: atfriesa01.ssi-schaefer.com
Received: from atfriesa01.ssi-schaefer.com (HELO atfriesa01.ssi-schaefer.com) (193.186.16.100) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 22 Oct 2019 10:06:44 +0000
Received: from samail03.wamas.com (HELO mailhost.salomon.at) ([172.28.33.235])  by atfriesa01.ssi-schaefer.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Oct 2019 12:06:41 +0200
Received: from [172.28.42.244]	by mailhost.salomon.at with esmtp (Exim 4.77)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1iMr3o-0001EA-EY; Tue, 22 Oct 2019 12:06:40 +0200
Subject: Re: [PATCH] Cygwin: pty: Disable clear screen for ssh sessions with -t option.
To: cygwin-patches@cygwin.com
References: <20191018113721.2486-1-takashi.yano@nifty.ne.jp> <b13f5d3c-c557-ff4e-6fcd-399952bad47e@ssi-schaefer.com> <20191022080402.GO16240@calimero.vinschen.de>
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Openpgp: preference=signencrypt
Message-ID: <40c9d2ad-24a5-400a-abd4-af4235b83e2a@ssi-schaefer.com>
Date: Tue, 22 Oct 2019 10:06:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191022080402.GO16240@calimero.vinschen.de>
Content-Type: multipart/mixed; boundary="------------BF881BCA013A16CBF9A887DD"
X-SW-Source: 2019-q4/txt/msg00054.txt.bz2

This is a multi-part message in MIME format.
--------------BF881BCA013A16CBF9A887DD
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-length: 1885

On 10/22/19 10:04 AM, Corinna Vinschen wrote:
> On Oct 22 09:20, Michael Haubenwallner wrote:
>> On 10/18/19 1:37 PM, Takashi Yano wrote:

>>> +      const char *term = getenv ("TERM");
>>> +      if (term && strcmp (term, "dumb") && !strstr (term, "emacs") &&
>>> +	  wcsstr (myself->progname, L"\\usr\\sbin\\sshd.exe"))

>> Again, my real problem does not utilize ssh at all, but is some python script
>> using multiple pty.openpty() to spawn commands inside, to allow for herding
>> all the subprocesses started by the commands (Ctrl-C or similar).

> In terms of clearing the screen at all, what's your opinion, Michael?

While I do not fully understand TTY handling, clearing the screen because
just opening a PTY doesn't feel correct.

To start with, attached is some python script where I do not expect to see
the initial clear screen code, but the one from /usr/bin/clear only.

This is what I see with python3 on *Linux*:

$ TERM=dumb python3 ./ptytest1.py 
select read: [3] except: []
read: b'/home/haubi\r\n'
select read: [3] except: []
quit: [Errno 5] Input/output error

$ TERM=xterm python3 ./ptytest1.py 
select read: [3] except: []
read: b'/home/haubi\r\n'
select read: [3] except: []
read: b'\x1b[H\x1b[2J\x1b[3J'
select read: [3] except: []
quit: [Errno 5] Input/output error

$ TERM=screen python3 ./ptytest1.py 
select read: [3] except: []
read: b'/home/haubi\r\n'
select read: [3] except: []
read: b'\x1b[H\x1b[J'
select read: [3] except: []
quit: [Errno 5] Input/output error

Note that the clear screen code does depend on the TERM value, and /usr/bin/clear
does even yell if TERM is empty, unknown or unset.

Also note that Linux select() does not yield the fd as exception when it was closed.

Interesting enough, cygwin-3.0.7 does dump core somewhere in between, so the real
python program probably does some additional setup I've not extracted yet.

/haubi/

--------------BF881BCA013A16CBF9A887DD
Content-Type: text/x-python;
 name="ptytest1.py"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="ptytest1.py"
Content-length: 602

#! /usr/bin/env python

import pty
import os
import select
import sys

(masterfd, slavefd) = pty.openpty()

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

--------------BF881BCA013A16CBF9A887DD--
