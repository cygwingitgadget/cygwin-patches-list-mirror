Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 by sourceware.org (Postfix) with ESMTPS id CB107389443C
 for <cygwin-patches@cygwin.com>; Mon,  3 May 2021 10:43:24 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org CB107389443C
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M7JrG-1lebyf48TM-007ihY for <cygwin-patches@cygwin.com>; Mon, 03 May 2021
 12:43:23 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id CABC7A80D64; Mon,  3 May 2021 12:43:19 +0200 (CEST)
Date: Mon, 3 May 2021 12:43:19 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Use automake (v5)
Message-ID: <YI/Tx0ryd7qhMhos@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210420201326.4876-1-jon.turney@dronecode.org.uk>
 <d4964f52-518e-205b-c44f-02bea6a225d6@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d4964f52-518e-205b-c44f-02bea6a225d6@dronecode.org.uk>
X-Provags-ID: V03:K1:abzDIY25KSH72cMAzjrsgsNm/CwrkXJb46fRHnghIrgPy5PCbQI
 hSJnHLe6+bz3iE1VZvK6gjc+52iEHKQvsPW9OZkULz0CJNqrU8SCFCxOfnykatdJ16IAXkc
 Zf0VhPXEarHTMl1F4HWNZT1n58/KZJO3HDJ+yrLJmZW7G/imBa5BYob0wmvkJ0g8YzUFmyE
 2/IZ7BMOJf2fPD8W5SMCA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Y+QjhtwtUlg=:1uB0VUE0HE23kLj9AwMaNE
 vBpS8kdrw+cnWUQ2Z3/nr+4hhYvPCC5yUj2A8z9Yr0GE2zI5bKg7g3ft3DkyXMRjAkMmk+0pN
 ul2dvj94QgglVXB57XY7CZBC7G/U2dnSrarOVSPotGlwG7/UjyoYq5hLEQjReJneAIaxnk7Ee
 kM52PaMP6HA2y81rRgbujyb9tgBT7M/j8J5KqruIZ4oGri+cQbpyTM7EpUDqwqKHtXfIo+SZR
 O4LeKo4lH2SNVjO3pwVtNlgD/cX4dWWIXZrra2ckq8pctPkbgnLOAQzOjE9BGLOByNBd0zkZF
 xUZRC5oMAdiV9K52Bh8+/ARSOrBXb3ShYgJOhAyssebZnRx4Sp1IEIVMuvwi3EYtFYf366z/x
 w5V2pUaVZRyknVh6mEMgItXF7LJxs1RqSG0i5Ub7HvnU2DzhmVFWsSV2n3WZPAKS+AFuQJTJ2
 M/kam3eMFxVmx3vB2Cb1eGWjQwc8p3T9qBPG1mvuvRqoXfVxzjV3ay0cjAPUW/ZoNW5UF7Hwn
 sccliZGj+G8kxo8f21osCY=
X-Spam-Status: No, score=-100.3 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H4, RCVD_IN_MSPIKE_WL, SPF_HELO_NONE, SPF_NEUTRAL,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
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
X-List-Received-Date: Mon, 03 May 2021 10:43:26 -0000

On May  2 16:28, Jon Turney wrote:
> On 20/04/2021 21:13, Jon Turney wrote:
> > For ease of reviewing, this patch doesn't contain changes to generated
> > files which would be made by running ./autogen.sh.
> 
> Some possible items of future work I noted:
> 
> * Documentation is now always built (rather than dangerously ignoring any
> errors)
> 
> Although this is half-arsed at the moment, as we don't require the
> documentation tools at configure time, we'll just fail when the rules are
> executed if they are missing.
> 
> Perhaps there should be explicit configuration to build documentation or
> not?

`make doc'?

It wouldn't be tricky to add that to the cygwin.cygport file...

> * Use AM_V_GEN to silence (most?) custom rules
> 
> * -Wimplicit-fallthrough, -Werror could (should?) be set in top-level
> Makefile.am.common, rather than individual subdirs

See my other mail.

> * Some custom rules have multiple outputs and workarounds to ensure the rule
> only runs once
> 
> Ideally these would be re-written using make 4.3 'grouped targets', but
> perhaps not yet...
> 
> * Some custom rules could be simplified
> 
> e.g. mkvers.sh generates version.cc and winver.rc, then runs windres on
> windver.rc
> 
> * 'make our include directories absolute so we don't have to worry about
> making them relative to the subdirectory we happen to be building in' is
> sufficiently obscure that it at least deserves a comment.

I'm not sure I understand... -v, please?

> * Rather than a huge list of --replace options to mkimport inline in the
> Makefile, it might be more sensible to augment that tool the read a list of
> replacement names from a file, and put them there.

Ack


Thanks,
Corinna
