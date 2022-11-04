Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
	by sourceware.org (Postfix) with ESMTPS id 45393385840D
	for <cygwin-patches@cygwin.com>; Fri,  4 Nov 2022 13:16:47 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 45393385840D
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MBDvU-1ojqLL0sgg-00Cfhj for <cygwin-patches@cygwin.com>; Fri, 04 Nov 2022
 14:16:45 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 9DB20A80C18; Fri,  4 Nov 2022 14:16:44 +0100 (CET)
Date: Fri, 4 Nov 2022 14:16:44 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Improve FAQ on early breakpoint for ASLR
Message-ID: <Y2UQvCw5NXNIYHTb@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20221103170430.4448-1-jon.turney@dronecode.org.uk>
 <alpine.BSO.2.21.2211031120540.30152@resin.csoft.net>
 <Y2TqvPTB7Hui2jmJ@calimero.vinschen.de>
 <4ccbb5e1-ee4f-8944-ed44-4af7fa79f048@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4ccbb5e1-ee4f-8944-ed44-4af7fa79f048@dronecode.org.uk>
X-Provags-ID: V03:K1:HRTolC7pAL7mez4O+4zsVzYhAwkqwjDgr6qeqXnhf6wKDzWeOGf
 f2om/PjAgCN4/idmvL8HmuuKKp0I3q/sp22T5xjBym9J+V8qljurOTcB0ySg7UlWK2DWITZ
 Um8GiA1YmiV61mpCFOtbd0bSQTbFW0EWQouL+Yu0lU8z+aTMTrfjs+nvbncDc6Aqsznkuq/
 TuGTr3h30UA3gBepQ2c/A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/jmBKSg04Fs=:CiYyQEWhZVCh0t1r6w06Dc
 A56w7v99GZ5eR0a7E/gWy/MSP9iNkh8ezjH98Axf4qxGABGA5v7jXcS+IL/6fd2t3QsrGCeWu
 rEPb/QN//K5+4k/XsmALh8PCnAst+Uz1PKz3sCV2pQx/aiVNCmWDU7qCXlmxGRkmgJOr20Nea
 Nz/DGJUBYzNUtkH0jOCPNC/outrPbhZXqCI4eDMG3WhCrJKns32uz9HEOGzVapj2i165KZG4H
 oewKfyTo9zbNfknz9urBvqfpxhgCLzWr0B/Ux9/2EQOm+FKvQDz7MjRnIWCAaS72cerWKDbgF
 X9a4Kz7/OVqexL3q7IM+N/VfUSQIUWBZ4PBqGJsa74WsZtzfta/Yi36EkP6UW0QF5PZ1sOxRv
 EECCfUk8aGExZYMO3Fk7Fcj8VohhiZOfvscWyBcWtiAlnBTrNkZJHgmlmWm4YQQaZ4W+4T+Fg
 cW4GwtEc6olsGajf73P5hi9mK5PzZ9mgeol3wy2JA88OjvCqy/9M4PXsvey0bxlhE4U8HSapx
 IrWkzxjmzeZkqrvnK4Q80RwCcLFPboUb3FDPG4sk7TBaKkGUTVL3GZ9hJePWeGcC2sT2APuya
 ePxH0pTK7mxii+anzzCTwTU3+UWCpXyW7i6wBlja0S7rBjG0L8PD+BlKsEx4oY4pzzjlYfamw
 S05gDc2wa70rGAJv+lk8UcGtUqGHVYrW8TB9VYk/mgagIkUid3QsgbWMg28hogl24IAlpPBzY
 +uLLuf2MV5XE56vZK/auMmVbixbrN19y9yIag3tmiw9cN4TdxmmGNS5nd5n2Oc1M2oXQ086kw
 Q3GIumFUN81CvQXnp4FSfR3UA22uw==
X-Spam-Status: No, score=-101.7 required=5.0 tests=BAYES_00,GIT_PATCH_0,GOOD_FROM_CORINNA_CYGWIN,KAM_DMARC_NONE,KAM_DMARC_STATUS,KAM_LOTSOFHASH,RCVD_IN_DNSWL_NONE,SPF_FAIL,SPF_HELO_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Nov  4 12:53, Jon Turney wrote:
> On 04/11/2022 10:34, Corinna Vinschen wrote:
> > On Nov  3 11:22, Jeremy Drake via Cygwin-patches wrote:
> > > On Thu, 3 Nov 2022, Jon Turney wrote:
> > > 
> > > > gdb supports 'set disable-randomization off' on Windows since [1]
> > > > (included in gdb 13).
> > > > 
> > > > https://sourceware.org/git/?p=binutils-gdb.git;a=commitdiff;h=bcb9251f029da8dcf360a4f5acfa3b4211c87bb0;hp=8fea1a81c7d9279a6f91e49ebacfb61e0f8ce008
> > > 
> > > Is it really *disable*-randomization *off*?  The double-negative seems to
> > > suggest that in that case ASLR would be left *on*.
> > 
> > Yeah, sounds weird....
> 
> Yes, this is just stupidity.  Revised patch attached.

Heh, please push.


Thanks,
Corinna

> From 9ffce0d6124933cf16aee3ad006e32858fe0754a Mon Sep 17 00:00:00 2001
> From: Jon Turney <jon.turney@dronecode.org.uk>
> Date: Tue, 1 Nov 2022 16:52:57 +0000
> Subject: [PATCH] Cygwin: Improve FAQ on early breakpoint for ASLR
> 
> gdb supports the 'disable-randomization' setting on Windows since [1]
> (included in gdb 13).
> 
> https://sourceware.org/git/?p=binutils-gdb.git;a=commitdiff;h=bcb9251f029da8dcf360a4f5acfa3b4211c87bb0;hp=8fea1a81c7d9279a6f91e49ebacfb61e0f8ce008
> ---
>  winsup/doc/faq-programming.xml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/winsup/doc/faq-programming.xml b/winsup/doc/faq-programming.xml
> index 7945b6b88..36d0a401f 100644
> --- a/winsup/doc/faq-programming.xml
> +++ b/winsup/doc/faq-programming.xml
> @@ -844,6 +844,12 @@ Guide here: <ulink url="https://cygwin.com/cygwin-ug-net/dll.html"/>.
>    Note that the DllMain entrypoints for linked DLLs will have been executed
>    before this breakpoint is hit.
>  </para>
> +
> +<para>
> +  (It may be necessary to use the <command>gdb</command> command <command>set
> +  disable-randomization on</command> to turn off ASLR for the debugee to
> +  prevent the base address getting randomized.)
> +</para>
>  </answer></qandaentry>
>  
>  <qandaentry id="faq.programming.debug">
> -- 
> 2.38.1
> 

