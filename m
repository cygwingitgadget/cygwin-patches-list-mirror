Return-Path: <cygwin-patches-return-4614-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5112 invoked by alias); 22 Mar 2004 17:05:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5101 invoked from network); 22 Mar 2004 17:05:38 -0000
Date: Mon, 22 Mar 2004 17:05:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Patch 20040321 for audio recording with /dev/dsp (indented)
Message-ID: <20040322170538.GJ17229@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <01C40F97.A1C224B0.Gerd.Spalink@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01C40F97.A1C224B0.Gerd.Spalink@t-online.de>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q1/txt/msg00104.txt.bz2

On Mar 21 22:55, Gerd Spalink wrote:
> There were no comments about the test program I sent. Do you want to
> put it or something like it into the repository?

I used your test application after applying the patch locally.

Some of the tests don't emit a sound, is that correct?

  $ ./devdsp
  Set bits=16 stereo=1 rate=44100 sync=0x00000000
  Buffer size=22080
  Formats=00000018

  [Beeping starts here]

  Set bits= 8 stereo=0 rate=44100 sync=0x00000000
  Set bits=16 stereo=0 rate=44100 sync=0x00000000
  Set bits= 8 stereo=1 rate=44100 sync=0x00000000
  Set bits=16 stereo=1 rate=44100 sync=0x00000000
  Set bits= 8 stereo=0 rate=22050 sync=0x00000000
  Set bits=16 stereo=0 rate=22050 sync=0x00000000
  Set bits= 8 stereo=1 rate=22050 sync=0x00000000
  Set bits=16 stereo=1 rate=22050 sync=0x00000000
  Set bits= 8 stereo=0 rate= 8000 sync=0x00000000
  Set bits=16 stereo=0 rate= 8000 sync=0x00000000
  Set bits= 8 stereo=1 rate= 8000 sync=0x00000000
  Set bits=16 stereo=1 rate= 8000 sync=0x00000000

  [From now on, the tests make *no* sound]

  Set bits= 8 stereo=0 rate=44100 sync=0x00000000
  Set bits=16 stereo=0 rate=44100 sync=0x00000000
  Set bits= 8 stereo=1 rate=44100 sync=0x00000000
  Set bits=16 stereo=1 rate=44100 sync=0x00000000
  Set bits= 8 stereo=0 rate=22050 sync=0x00000000
  Set bits=16 stereo=0 rate=22050 sync=0x00000000
  Set bits= 8 stereo=1 rate=22050 sync=0x00000000
  Set bits=16 stereo=1 rate=22050 sync=0x00000000
  Set bits= 8 stereo=0 rate= 8000 sync=0x00000000
  Set bits=16 stereo=0 rate= 8000 sync=0x00000000
  Set bits= 8 stereo=1 rate= 8000 sync=0x00000000
  Set bits=16 stereo=1 rate= 8000 sync=0x00000000
  Set bits=16 stereo=1 rate=44100 sync=0x00000000

  [And now the beeping starts again]

  forked, child PID=1812 parent records
  [...]

I'm not quite sure about putting the testcase into the testsuite.
It's a good idea in general, but, well, I'm wondering if you'd
like to use the libltp framework for the testresults, perhaps?

Btw., what happens if somebody without sound card and sound driver
starts the test?  Did you check that?

Other than that your latest patch looks pretty good, though there
are still a few formatting issues, e. g.

  if (foo &&
      bar

should be

  if (foo
      && bar)

in GNU coding style.  However, I'll apply it after 1.5.10 is out
and run indent on it, as soon as you can explain to me (as a sound
programming anaphylactic) why I can't hear a sound in the above
tests.

Since that code makes you to the one and only audio code maintainer
for Cygwin, I'm wondering if you're also interested in maintaining
some audio application which makes use of this new Cygwin code,
as part of the Cygwin net distribution...


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
