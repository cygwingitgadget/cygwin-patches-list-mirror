Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 by sourceware.org (Postfix) with ESMTPS id 2CFCF3850424
 for <cygwin-patches@cygwin.com>; Mon, 23 Nov 2020 08:45:24 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 2CFCF3850424
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mysa4-1kKcVs0D2Y-00vxKS for <cygwin-patches@cygwin.com>; Mon, 23 Nov 2020
 09:45:22 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 07F6DA8097E; Mon, 23 Nov 2020 09:45:21 +0100 (CET)
Date: Mon, 23 Nov 2020 09:45:21 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: proc(5) and xml version
Message-ID: <20201123084521.GL303847@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <072e5252-9056-2af8-bf62-caec89830d38@SystematicSw.ab.ca>
 <20201116120721.GA41926@calimero.vinschen.de>
 <96c4beb9-67a6-5f71-9d22-c7e5bbc6a0fc@dronecode.org.uk>
 <806e3ae9-badf-497e-8c56-eaf1bc9b0af1@SystematicSw.ab.ca>
 <451c49af-7a9e-bc70-459a-b67170d5ed50@SystematicSw.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <451c49af-7a9e-bc70-459a-b67170d5ed50@SystematicSw.ab.ca>
X-Provags-ID: V03:K1:ShGwz1oaaWL6sgqFPT9yAmjgpqE5zbE1PG9J+op9DF7X+7jsfLV
 9d5UyzFCB//xGN1SGG4MOODJGuh6hmDQMZWK6+c56QExZ9ej9qjUJU88Yut6lTl5i9Pr/xm
 Acif7P93q2NhGuetYxzSaljUZ33JmZDJL5n/0Ftu3AQ6oaq0UOo5U3yaacXCtI78WEWTx4+
 wdGy8QchkgV0bVV3TpwtA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:S2SFJlVTFK4=:ZzTvUheokOuWl46vd+b0s1
 cF1ZAyOCz3A54dlj2IgepeR8DuYV2y3eWgZnPae2mKDnD4vxExuRCzyoWEGFZ4ui7LwTSutCU
 wKfeUvtIyZFCdQd2Pui7vN91MpGKbAXlfgI8OKbQGYVqg6xoSem+pKC779mRc3cNM+Al4DL0S
 uAOSGpGdu8BhVY2bpIsE9O3GwVHUkIY2ab8Svk/CPL7hQgpujf6zor65vSs9ggeCA8oLkbSDC
 ZQHYSX9KMszFOlALWmA4+Q272xQM0zQ0whvg385+tVKT/Bo3V35Lc0px0tpeAD1+jziA2KdkL
 N5veCk73IglSU2HL+8Am4flbqSwWqK36ADu+eO/Y7FXoNiwMVR/dBrd4VmR0d0ZfjrvRPoMry
 zD0wwCmThYUFDmSX19U3yGThfqnbwDNEDSlrnmhpqXYleuowYUhJm1CC8cZilUXn+QmO30lC6
 IH0hyxNQSg==
X-Spam-Status: No, score=-100.8 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Mon, 23 Nov 2020 08:45:25 -0000

On Nov 20 09:42, Brian Inglis wrote:
> On 2020-11-16 16:21, Brian Inglis wrote:
> > On 2020-11-16 06:41, Jon Turney wrote:
> > > On 16/11/2020 12:07, Corinna Vinschen wrote:
> > > > Hi Brain,
> > > > 
> > > > On Nov 13 07:25, Brian Inglis wrote:
> > > > > Hacked a Cygwin proc.5 man page FMOI over time, by combing through
> > > > > fhandler_proc..., converted to proc-5.xml using doclifter, back with xmlto
> > > > > as in the build, man width 80 output from both, and diff (all attached).
> > > > 
> > > > Nice idea!
> > > > 
> > > 
> > > Yes, nice work.
> > > 
> > > > > Unsure how this might best be fitted into the distro (cygwin, cygwin-doc,
> > > > > ...?) and/or whether there may be xml remediation possible to generate
> > > > > verbatim output left justified with zero margin, and character value
> > > > > displays, the major output issues in the diff? Content feedback is also
> > > > > welcome.
> > > > 
> > > > This could replace the pathnames-proc and pathnames-proc-registry
> > > > sections in specialnames.xml.
> > > > 
> > > > I think by using the refentry markup the man page would be generated
> > > > automagically, but Jon (CCed) is the definitiv source of wisdom here.
> > > 
> > > Yes, all refentries in the UG should have manpages generated from
> > > them (only cygwin utilities currently).
> > 
> > I saw those but not specialnames, so should be able to incorporate the
> > comments to update the content, generate the xml and adapt to the
> > existing context as an update, then look at manpage generation.
> > 
> > > The install rule in the Makefile would probably need extending to
> > > install *.5 to man5dir.
> > > 
> > > These would then be included in the cygwin-doc package.
> > 
> > Great, that sounds workable.
> 
> Attaching UG build doc outputs as results easier to see and review and
> change more obvious, rather than specialnames.xml and Makefile.in patches
> for now, as git does not appear to like non-patch attachments.

The actual patch is preferable, actually.


Thanks,
Corinna

