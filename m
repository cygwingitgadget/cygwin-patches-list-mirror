Return-Path: <cygwin-patches-return-4623-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27352 invoked by alias); 23 Mar 2004 11:09:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27333 invoked from network); 23 Mar 2004 11:09:34 -0000
Date: Tue, 23 Mar 2004 11:09:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Patch 20040321 for audio recording with /dev/dsp (indented), test issues
Message-ID: <20040323110933.GM17229@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <01C41057.52EAB850.Gerd.Spalink@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01C41057.52EAB850.Gerd.Spalink@t-online.de>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q1/txt/msg00113.txt.bz2

On Mar 22 21:47, Gerd Spalink wrote:
> >   [From now on, the tests make *no* sound]
> > 
> This is correct, since the following are the tests for audio
> recording. They record whatever is at your currently
> selected analog audio source (could be MIC, LINE, CD),
> and silently ignore the recorded sound data.

Uh, ok, that makes sense.

> > I'm not quite sure about putting the testcase into the testsuite.
> > It's a good idea in general, but, well, I'm wondering if you'd
> > like to use the libltp framework for the testresults, perhaps?
> >
> I agree. The printed results will be unambiguous, so no more
> wondering about correctness or not.

Cool.

> Actually, I tried "indent" as distributed with cygwin, and it apparently
> did strange things to the C++ code, e.g. "delete[] foo;" became "delete[]foo;"
> I found also that the code in the class declarations looked worse than before.
> Do you have a special set of options that work better than the default for C++?

No, I don't.  I had a bit weird results, too, so I just tweaked some
lines by hand.  Chris, do you have a personally approved set of indent
options which give a useful result, perhaps?

> > Since that code makes you to the one and only audio code maintainer
> > for Cygwin, I'm wondering if you're also interested in maintaining
> > some audio application which makes use of this new Cygwin code,
> > as part of the Cygwin net distribution...
> >
> As far as my limited spare time allows...
> Which applications were you thinking of?

I have no idea!  I thought you would know one, given that you cared for
the dsp code in Cygwin.

I've applied your patch.  It will go into 1.5.10 already.

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
