Return-Path: <cygwin-patches-return-4494-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6123 invoked by alias); 10 Dec 2003 01:34:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6112 invoked from network); 10 Dec 2003 01:34:05 -0000
Date: Wed, 10 Dec 2003 01:34:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: patch for audio recording with /dev/dsp
Message-ID: <20031210013406.GA5140@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <01C3BD3C.95EC61D0.Gerd.Spalink@t-online.de> <3FD6609A.2090303@netscape.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FD6609A.2090303@netscape.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q4/txt/msg00213.txt.bz2

On Tue, Dec 09, 2003 at 06:54:02PM -0500, Nicholas Wourms wrote:
>Gerd Spalink wrote:
>
>>Hi,
>>
>>This patch changes the device /dev/dsp so that audio recording works.
>>I have tested it with
>>cp /dev/dsp test.wav         (stop by hitting ctrl-C)
>>and subsequent playback with
>>cp test.wav /dev/dsp
>>
>>I also tested successfully with bplay of the gramofile package
>>(with some hangups that I link to the terminal handling of this software).
>
>Awesome, thanks for doing this!  I hope it won't be too much trouble for 
>you to fill out that small assignment form mentioned in the other reply. 
> Otherwise, we'll not be able to use this :-(.
>
>>I am now considering implementing /dev/mixer ...
>
>Awhile back, a guy devised a drop-in replacement for /dev/mixer for when 
>you compile the ESounD daemon on Cygwin.  I don't know if it is of any 
>use, but I found it interesting:
>
>http://www.kiss.taihaku.sendai.jp/~fuji/product/esd.patch

...and if he reads it, he'll be contaminated by a patch which is not
associated with an assignment...

cgf
