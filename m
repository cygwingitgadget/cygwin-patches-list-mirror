Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 by sourceware.org (Postfix) with ESMTPS id 76C7B383B7A9
 for <cygwin-patches@cygwin.com>; Wed, 15 Jun 2022 12:30:08 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 76C7B383B7A9
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N6c0W-1nejJo2HeQ-0181td for <cygwin-patches@cygwin.com>; Wed, 15 Jun 2022
 14:30:06 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id D142EA80B81; Wed, 15 Jun 2022 14:30:05 +0200 (CEST)
Date: Wed, 15 Jun 2022 14:30:05 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Make 'ulimit -c' control writing a coredump
Message-ID: <YqnQzVMifY8j+aK8@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20220615112115.21040-1-jon.turney@dronecode.org.uk>
 <b288ba30-650b-d114-c139-f1f5df6e8958@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b288ba30-650b-d114-c139-f1f5df6e8958@dronecode.org.uk>
X-Provags-ID: V03:K1:9SPOkeef3At34gR58pW4xoCqnC6r9/CGILcTDfoQyovQyagwwdg
 8xJaFSfIKkEvcJ76nS1Ga8jYgcLyGUMqPNfaVz0pV8/xbUGc/sJa3lGe4F/PbyERaf7+qvD
 ySZjOYo+SUhUgdpSw0nlBpIkyxsgj/hdDfvEbA6izCcGwMd+ecHlNvHH0Qx/iGJfvDkFXha
 k7H2PWb3GJSTbFr+ptHcQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Qa8FuBgQApc=:NLoIKf6sJdhECHbA2uYVgU
 DyG6M090sVwV/EuY0PXFgYL9OYfthL337YMTzTgHnnvg6PjEYlP+6NrSggoYBOgvO+6zwwzp6
 lNiI5g51BJ7EaBLfZLs/15Su1IHagyGS/SvcGuFjsdm1Oh9fhXikySH6XJQqrLYzjOGL1LNNe
 +D/SQNxjlLNl3eXhwmCPmM34EKj46e0N7L44WVqfe4/NVR0LjGgW+XZB5j6mwnUocljS8v2s+
 2s1DSFD4eCE6XdhZd41YaqYua5F+1800L/ZTibD6UKgooeSCaF3kKdEDyff5EdrGxvMm6f/lA
 XGw/Og4at48UKQ54FWdNIF/gVGdSb7WamjBudDyuPxh8S4iThiuJiR+YdpkoJ7+gm+vDi6TRv
 jJzbzWzjFb6UgvsQOAIAPbSpk0Wbq+OEkSoxxCk4tdAelMzIOIFdrDiNvrbybb32QhwHByGz1
 uOQPmup5hAO72bPmBTDIW+MZjpTG5RwlmtgnfZAXykr7D2WB0sWrEsIb6iwCvWRu1LvsD9coM
 6cERmCAcEJo0PaXJCiqPFG0odOtuA8nVx9ZmY76Wg2hC01XcEuTefLhNIy/+fq558C5WLJNlX
 /oiXLUTneBCyKARxl9Rqs/L3cEwuehgxKkEJDkHX235mq3Bodf4A2b4AXBho7FCqbmaCANH/r
 x5x3Co940SBQvXPmJ92uRa9xmI+svbuaihCDwhNGd9VHkVkEKX81RDNguh4LfLlHF6FGbe+Qj
 hrumJ3oWCteUOt5LYLQQsfoMnrYDOJI2sWst+sh8jEfdud01Elcu/Ow4Izk=
X-Spam-Status: No, score=-94.9 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_MSPIKE_H2,
 SPF_FAIL, SPF_HELO_NONE, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
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
X-List-Received-Date: Wed, 15 Jun 2022 12:30:10 -0000

On Jun 15 12:40, Jon Turney wrote:
> On 15/06/2022 12:21, Jon Turney wrote:
> > Factor out pre-formatting a command to be executed on fatal signal, and
> > use that for both error_start (if present in the CYGWIN env var) and for
> > 'dumper'.
> > 
> > Factor out executing that command, so we can use it from try_to_debug()
> > and when a fatal signal occurs.
> > 
> > Because we can't control the size of the core dump written by that, only
> > invoke dumper if the core file size limit is unlimited.
> > 
> > Otherwise, if that limit is greater than 0, we will write a .stackdump
> > file, as previously.
> > 
> > Change the default limit from unlimited to 1 MB, to preserve that
> > existing behaviour.
> 
> Maybe this design tries too hard not to change anything and instead we
> should:
> 
> keep default ulimit -c as unlimited
> 
> ulimit 0     write nothing
> ulimit <=4K  write a .stackdump [*]
> ulimit >4K   write a .core

Sounds good.

> In cases where we wrote something, check afterwards if it's bigger than the
> ulimit and if so, remove it.
> 
> (Maybe this still loses if e.g. 1MB of disk space remains, ulimit is 2MB,
> actual size of coredump is 3MB, since we'll end up with a partial coredump
> when we shouldn't have written anything, but maybe that's what's supposed to
> happen?)

If disk space is low, shit happens.


Corinna
