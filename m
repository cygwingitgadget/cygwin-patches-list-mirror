Return-Path: <cygwin-patches-return-4493-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 403 invoked by alias); 9 Dec 2003 23:54:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 32646 invoked from network); 9 Dec 2003 23:54:12 -0000
Message-ID: <3FD6609A.2090303@netscape.net>
Date: Tue, 09 Dec 2003 23:54:00 -0000
From: Nicholas Wourms <nwourms@netscape.net>
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Gerd.Spalink@t-online.de" <Gerd.Spalink@t-online.de>
CC: cygwin-patches@cygwin.com
Subject: Re: patch for audio recording with /dev/dsp
References: <01C3BD3C.95EC61D0.Gerd.Spalink@t-online.de>
In-Reply-To: <01C3BD3C.95EC61D0.Gerd.Spalink@t-online.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AOL-IP: 130.127.121.187
X-SW-Source: 2003-q4/txt/msg00212.txt.bz2

Gerd Spalink wrote:

> Hi,
> 
> This patch changes the device /dev/dsp so that audio recording works.
> I have tested it with
> cp /dev/dsp test.wav         (stop by hitting ctrl-C)
> and subsequent playback with
> cp test.wav /dev/dsp
> 
> I also tested successfully with bplay of the gramofile package
> (with some hangups that I link to the terminal handling of this software).

Awesome, thanks for doing this!  I hope it won't be too much trouble for 
you to fill out that small assignment form mentioned in the other reply. 
  Otherwise, we'll not be able to use this :-(.

> I am now considering implementing /dev/mixer ...

Awhile back, a guy devised a drop-in replacement for /dev/mixer for when 
you compile the ESounD daemon on Cygwin.  I don't know if it is of any 
use, but I found it interesting:

http://www.kiss.taihaku.sendai.jp/~fuji/product/esd.patch

If you feel the libmm api isn't robust enough, you might consider using 
the DirectSound API, since it should provide the advanced features 
necessary to support a rich mixer without being dependent on one sound 
card or another.  Depending on how current and/or complete the 
DirectSound support is in the w32api libraries, you may have to do some 
  work on them first.

Something else that would be nice to have would be very basic midi 
support, which you might consider doing if you're going to do mixer.

One final thought, one thing which would compliment the addition of 
/dev/mixer would be the port of either the alsa or oss library to 
Cygwin.  Even just providing a set of wrapper functions around the 
w32api would nice.  I know we currently have the header for oss, but 
some apps require the supplementary functions found in the library 
itself.  And now, more and more, applications are moving towards using 
alsa as the default.  Anyhow, that's something to consider if you care to.

Cheers,
Nicholas
