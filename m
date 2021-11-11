Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 by sourceware.org (Postfix) with ESMTPS id 5A0BA3858402
 for <cygwin-patches@cygwin.com>; Thu, 11 Nov 2021 09:47:40 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 5A0BA3858402
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MhDEq-1mGjfc2veE-00eNvU for <cygwin-patches@cygwin.com>; Thu, 11 Nov 2021
 10:47:38 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 4FE3CA80A5B; Thu, 11 Nov 2021 10:47:35 +0100 (CET)
Date: Thu, 11 Nov 2021 10:47:35 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/2] Fix a bad case of absolute path handling
Message-ID: <YYzmt2ZY5UbhMyHB@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20211110203253.2933679-1-corinna-cygwin@cygwin.com>
 <f6a4f67f-1db4-4e53-7907-c7a7dcfbde79@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f6a4f67f-1db4-4e53-7907-c7a7dcfbde79@cornell.edu>
X-Provags-ID: V03:K1:779WYQ0tgTLkgxAqxg2PKNVJjsc/MyPhEcVBQnhOMZdESxw4LCn
 cWR0ScFCavwp4zgTzgmZme9oJL4ig59JMdqUQwsCjaCleBEnpgKePsZpdRe6Sbiw5IAzAY1
 GhWH1k8qOupK4MRJZADWx6m29cwJt6vn+TPxzN52l56szaAoXVDY+TFc+6Oe7sSKrEfZx30
 l26KPSE4N2JHQ1crgaJmg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1AYNsV9dWOM=:cyg0w+aPGupkTruMfan3yp
 HLFRShSJP6aOEiDZUly2d9ysjbgUBlPXmCyAx9a/JhPYUSN/Iid1Tz3EiCb8FOsNcG5rDBvDw
 bs84TWyNIYx82pJLCDjt0LVNvrjCQRqtRwZ8ui6I6GhcO8/Vwy2w1tJyN/LVg6A3gWEg5LTDj
 uWP2deOKEk19+PJmxdH2wO5S7l0coBkTKv9LhFJFkCqttU0GGQhJK86fSFaJ1M/8Dd0oUqMa/
 sleAn4R94/bxAEF+MRXnagYryx8MpzDWHHZyh5HgxnMv+9Af/86xJtO3mrc4sayq+mZaMviA/
 ZcwkbBolTMShhgqy0OSyk2rl10zB8s0NWP1luYh3LQu2UaNzc+8fFwHdBj58TBy5usGr59qXX
 hHfBxCpfqCJWXfwSs5FW2gTy+FtH9/IGLPLfUfUQ858CeJa8qW6M+T6D42nKYHmrtSUMH6QPa
 9QGSa9l1Mg+eKtn7BMhVPOco8MDTTW+jpDSi5xyEQ91EGIj81r6vumF42pIrAh8yq3xwHrVls
 WpRFFvUBadhxTUXp4sPNAr/uz1hsVAOGX3Na2fDfhP4Lej/XBGdzjpCjNIUy2PTC5qSXVWUK2
 UE0ADlMtjWlrtHOZAkHAZgdwg5ZmjFW3ixHzby3WrTz1DU4Rr0KJerGh+52jNi8K37c4yybn+
 FvYeZwSqZKJJN75AI4tzBP0qF4Ic6ytPhPYNLl9COkXC1Z9/l9er5Us2ORruYimzd5i+QQHJP
 hfPz/uuCeMXFmPzA
X-Spam-Status: No, score=-99.1 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_NONE, KAM_DMARC_STATUS,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
 TXREP autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Thu, 11 Nov 2021 09:47:42 -0000

On Nov 10 17:22, Ken Brown wrote:
> On 11/10/2021 3:32 PM, corinna-cygwin@cygwin.com wrote:
> > From: Corinna Vinschen <corinna@vinschen.de>
> > 
> > As I told Takashi in PM, I will try to more often send patches to the
> > cygwin-patches ML before pushing them, so there's a chance to chime in.
> 
> LGTM.
> 
> > This patch series is supposed to address the `rm -rf' problem reported
> > in https://cygwin.com/pipermail/cygwin/2021-November/249837.html
> > 
> > It was always frustrating, having to allow DOS drive letter paths for
> > backward compatibility.  This here is another case of ambiguity,
> > triggered by the `isabspath' macro handling "X:" as absolute path, even
> > without the trailing slash or backslash.
> > 
> > Check out the 2nd patch for a more detailed description.
> > 
> > While at it, I wonder if we might have a chance to fix these ambiguities
> > in a better way.  For instance, consider this:
> > 
> >    $ mkdir -p test/c:
> >    $ cd test
> > 
> > As non-admin:
> > 
> >    $ touch c:/foo
> >    touch: cannot touch 'c:/foo': Permission denied
> > 
> > As admin, even worse:
> > 
> >    $ touch c:/foo
> >    $ ls /cygdrive/c/foo
> >    foo
> > 
> > As long as we support DOS paths as input, I have a hard time to see how
> > to fix this, but maybe we can at least minimize the ambiguity somehow.
> 
> I can't immediately think of anything.  But is it really impossible to phase
> out DOS path support over a period of time?  We could start with a HEADS-UP,
> asking for comments, then a deprecation announcement, then something like
> the old dosfilewarning option, then a more forceful warning that can't be
> turned off, and finally removal of support.  This could be done over a
> period of several years (not sure how many).

Yeah, we might try again.  Just not over years, we'll probably lose
track over time.  I'd appreciate a shorter period with a chance to see
the end.

The problem is that people are probably using DOS paths all the time.
Makefiles and scripts mixing Cygwin and DOS tools come to mind.

For the time being, I wonder if we could start with isabspath being
always strict so at least X: isn't an abspath at all.

> 
> We could also put lines like
> 
>   # C:/ on /c type ntfs (binary,posix=0)
> 
> into the default /etc/fstab.

Commented out, you mean?  Just as hint?  We could do that.  Personally I
don't like these shortcuts, I rather use a shorter cygdrive prefix, like
/mnt, but I see how this could convince people.  Scripts with mixed
tools will always be a problem, though.


Corinna
