Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 by sourceware.org (Postfix) with ESMTPS id B01463858018
 for <cygwin-patches@cygwin.com>; Thu, 20 May 2021 17:57:55 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org B01463858018
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M72bv-1lp2Wz1COd-008cY7 for <cygwin-patches@cygwin.com>; Thu, 20 May 2021
 19:57:54 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id C7E6DA82BFD; Thu, 20 May 2021 19:57:53 +0200 (CEST)
Date: Thu, 20 May 2021 19:57:53 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: utils: chattr: Improve option parsing.
Message-ID: <YKajIZm3F4OpX5sx@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <d515bfba-ce77-40c0-0c3e-67895675f753@t-online.de>
 <YKVPOaBrb0a9lV54@calimero.vinschen.de>
 <e78257d8-bd2a-3ea0-0cea-48114ec017a0@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e78257d8-bd2a-3ea0-0cea-48114ec017a0@t-online.de>
X-Provags-ID: V03:K1:46oVoKOg0mMihEl2+AiAzZqiDO1Rn05sHJIhFVx2uwqis0DJ3rf
 v7z0tfcRxPxO08QtjrpV2md0/Ow6rexT2kh0Vep5sX66MePD6aDjabScnI5yOfvcuRbAeLM
 Qi5O3yPbuoOutcqBOCOdXusPxRMkmYyIZ9hw7/N8C2afdBfyIMJUw55mh2wbt7M6kRWmkst
 XP+aztI4X9GMHq0G//gUQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RKo2drhhY94=:/x7LA/krd1vlbtBSbhhEPZ
 auURaufPPAwfLt1DKH/eKfkBlaiYxi9iZ/fmtdrBp2mU27Aw92physGHmB/J/uxh8HcPwm/CJ
 7Zy6HU+38IaqQJftA+Xm9KuMZRdiouMxhvmqHLgoYe6z7QlraqjbbMOr6OpYum5wBh762YVLz
 WQTODfIwEvswB12EBAEO+LkNdLrbGtqWAbzbQG/DFM7v3IXi4OWy8qI7qet26ktJkeNJ5Zl/N
 ocNCfdGSrowxeNQLnh7Tk2Ti8daU0FOg0hyHUGoC8iAKmRlJIJwwaVS9qnBvcbsvHXaLTjEya
 qrozSUHoe0sJtC6hhulF4Zah4Gp6EWUZ9TTNpm1n9JKvDpIn84XkcPeVF+/cdFJvzMnEREAX/
 phQwLmVmXZnrY+uuQvNlf8ilA/245TM3mSiE9+qom9wgutzR1BAeUb1wS+a7VEezHxHJmfu4m
 XzW3xKwRsnufhP3qIvxYMeoN+InXrkc6jnaNN6UXHVQ+TK5+/3tzZWfvkXz1k1EjbCoiMGIn/
 aSQj1Ce717HuodknetRNuI=
X-Spam-Status: No, score=-98.6 required=5.0 tests=BAYES_00, BODY_8BITS,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_NONE, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Thu, 20 May 2021 17:57:57 -0000

Hi Christian,

On May 20 12:01, Christian Franke wrote:
> Corinna Vinschen wrote:
> > On May 19 17:46, Christian Franke wrote:
> > > ...
> > > $ egrep 'ACL|--r' chattr.c
> > >            "Get POSIX ACL information\n"
> > >        "  -R, --recursive     recursively list attributes of directories and
> > > their \n"
> > Oops.  Please patch while you're at it...
> > ...
> > >  From 865a5a50501f3fd0cf5ed28500d3e6e45a6456de Mon Sep 17 00:00:00 2001
> > > From: Christian Franke<...>
> > > Date: Wed, 19 May 2021 16:24:47 +0200
> > > Subject: [PATCH] Cygwin: utils: chattr: Improve option parsing.
> > > 
> > > Interpret '-h' as '--help' only if last argument.
> > Who was the idiot using -h for help *and* the hidden flag? *blush*
> > 
> > I'd vote for --help to be changed to -H for the single character
> > option.  The help output is very unlikely to be used in scripts,
> > so that shouldn't be a backward compat problem.
> 
> New patch attached.
> 
> Note that there is now the possibly unexpected (& hidden) behavior that
> 'chattr -h' without file argument clears the hidden attribute of cwd.

Uhm... why?  Isn't that easily avoidable?


Thanks,
Corinna
