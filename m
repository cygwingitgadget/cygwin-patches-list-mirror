Return-Path: <cygwin-patches-return-4619-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2142 invoked by alias); 22 Mar 2004 21:15:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2079 invoked from network); 22 Mar 2004 21:15:21 -0000
Message-ID: <01C41057.52EAB850.Gerd.Spalink@t-online.de>
From: Gerd.Spalink@t-online.de (Gerd Spalink)
Reply-To: "Gerd.Spalink@t-online.de" <Gerd.Spalink@t-online.de>
To: "'cygwin-patches@cygwin.com'" <cygwin-patches@cygwin.com>
Subject: RE: Patch 20040321 for audio recording with /dev/dsp (indented), test issues
Date: Mon, 22 Mar 2004 21:15:00 -0000
Organization: privat
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Seen: false
X-ID: EY+eMyZEQeZ8ayyhVkSFtCaDIy4I7f+4O7JJxldmP77IdxdP-OwA6C
X-SW-Source: 2004-q1/txt/msg00109.txt.bz2

Please find my answers inserted below.

On Monday, March 22, 2004 6:06 PM, Corinna Vinschen [SMTP:vinschen@redhat.com] wrote:
> On Mar 21 22:55, Gerd Spalink wrote:
> > There were no comments about the test program I sent. Do you want to
> > put it or something like it into the repository?
> 
> I used your test application after applying the patch locally.
> 
> Some of the tests don't emit a sound, is that correct?
> 
>   $ ./devdsp
>   Set bits=16 stereo=1 rate=44100 sync=0x00000000
>   Buffer size=22080
>   Formats=00000018
> 
>   [Beeping starts here]
> 
These are audio playback tests for various sampling rates

>   Set bits= 8 stereo=0 rate=44100 sync=0x00000000
>   Set bits=16 stereo=0 rate=44100 sync=0x00000000
>   Set bits= 8 stereo=1 rate=44100 sync=0x00000000
>   Set bits=16 stereo=1 rate=44100 sync=0x00000000
>   Set bits= 8 stereo=0 rate=22050 sync=0x00000000
>   Set bits=16 stereo=0 rate=22050 sync=0x00000000
>   Set bits= 8 stereo=1 rate=22050 sync=0x00000000
>   Set bits=16 stereo=1 rate=22050 sync=0x00000000
>   Set bits= 8 stereo=0 rate= 8000 sync=0x00000000
>   Set bits=16 stereo=0 rate= 8000 sync=0x00000000
>   Set bits= 8 stereo=1 rate= 8000 sync=0x00000000
>   Set bits=16 stereo=1 rate= 8000 sync=0x00000000
> 
>   [From now on, the tests make *no* sound]
> 
This is correct, since the following are the tests for audio
recording. They record whatever is at your currently
selected analog audio source (could be MIC, LINE, CD),
and silently ignore the recorded sound data.

>   Set bits= 8 stereo=0 rate=44100 sync=0x00000000
>   Set bits=16 stereo=0 rate=44100 sync=0x00000000
>   Set bits= 8 stereo=1 rate=44100 sync=0x00000000
>   Set bits=16 stereo=1 rate=44100 sync=0x00000000
>   Set bits= 8 stereo=0 rate=22050 sync=0x00000000
>   Set bits=16 stereo=0 rate=22050 sync=0x00000000
>   Set bits= 8 stereo=1 rate=22050 sync=0x00000000
>   Set bits=16 stereo=1 rate=22050 sync=0x00000000
>   Set bits= 8 stereo=0 rate= 8000 sync=0x00000000
>   Set bits=16 stereo=0 rate= 8000 sync=0x00000000
>   Set bits= 8 stereo=1 rate= 8000 sync=0x00000000
>   Set bits=16 stereo=1 rate= 8000 sync=0x00000000
>   Set bits=16 stereo=1 rate=44100 sync=0x00000000
> 
>   [And now the beeping starts again]
> 
>   forked, child PID=1812 parent records
>   [...]
> 
> I'm not quite sure about putting the testcase into the testsuite.
> It's a good idea in general, but, well, I'm wondering if you'd
> like to use the libltp framework for the testresults, perhaps?
>
I agree. The printed results will be unambiguous, so no more
wondering about correctness or not.
 
> Btw., what happens if somebody without sound card and sound driver
> starts the test?  Did you check that?

I did not check it. I guess that the calls into the /dev/dsp device
will fail at some point, resulting in a premature exit of the test
with a non-zero exit code, indicating failure to the test suite.

> 
> Other than that your latest patch looks pretty good, though there
> are still a few formatting issues, e. g.
> 
>   if (foo &&
>       bar
> 
> should be
> 
>   if (foo
>       && bar)
> 
> in GNU coding style.  However, I'll apply it after 1.5.10 is out
> and run indent on it, as soon as you can explain to me (as a sound
> programming anaphylactic) why I can't hear a sound in the above
> tests.

Actually, I tried "indent" as distributed with cygwin, and it apparently
did strange things to the C++ code, e.g. "delete[] foo;" became "delete[]foo;"
I found also that the code in the class declarations looked worse than before.
Do you have a special set of options that work better than the default for C++?

> 
> Since that code makes you to the one and only audio code maintainer
> for Cygwin, I'm wondering if you're also interested in maintaining
> some audio application which makes use of this new Cygwin code,
> as part of the Cygwin net distribution...
>
As far as my limited spare time allows...
Which applications were you thinking of?
> 
> Thanks,
> Corinna
> 
> -- 
> Corinna Vinschen                  Please, send mails regarding Cygwin to
> Cygwin Developer                                mailto:cygwin@cygwin.com
> Red Hat, Inc.
