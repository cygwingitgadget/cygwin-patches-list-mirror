Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 by sourceware.org (Postfix) with ESMTPS id 863563858D39
 for <cygwin-patches@cygwin.com>; Wed,  2 Mar 2022 21:04:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 863563858D39
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MMnnm-1nfx4O1AsG-00ImTp for <cygwin-patches@cygwin.com>; Wed, 02 Mar 2022
 22:04:32 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 5A33DA80571; Wed,  2 Mar 2022 22:04:31 +0100 (CET)
Date: Wed, 2 Mar 2022 22:04:31 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Cygwin sysconf.cc
Message-ID: <Yh/b31DA63xeRzAP@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20220225163959.48753-1-Brian.Inglis@SystematicSW.ab.ca>
 <20220225163959.48753-3-Brian.Inglis@SystematicSW.ab.ca>
 <Yhy6OKd/2o8VqIUH@calimero.vinschen.de>
 <d71a5b05-531f-8028-7b06-6ee466053f5f@SystematicSw.ab.ca>
 <2a8615a6-1214-ed7a-71f1-d191bcf2f3fe@SystematicSw.ab.ca>
 <Yh8p80lFZNuUYWTw@calimero.vinschen.de>
 <b7a385c3-5480-9881-9feb-7fb49350c755@SystematicSw.ab.ca>
 <Yh/VCzCrgxftws6+@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yh/VCzCrgxftws6+@calimero.vinschen.de>
X-Provags-ID: V03:K1:Vx5+lVuSCJcOp4nr6Kw6WHUzv9hPdSSBBP/kI8bLE6suXkrDm8w
 GH8cBtQSYaSsIuuE4SBY4TMSXgWt9QqeJC7Txa8pW4DQm+Eg+bJMi2cMnk/YmkaN3HIvkCn
 3fa8VsE/3wK1dmojesbh4MCcFVzrN0/uv+1jYaMwdK91/OAUv5HGrECFjK24az6BuNarSJr
 my2KPFKsh3OfziTSNDfyA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UwAacAsJ3BA=:9HILcJbApD4lwuK9GNJ23S
 6TR+Vd70/9MGc8qEGOwpM3i4KEjuAns3R2b6zNLfZJOVh+L+rBIKtnjW6CMv28tZGP7eAwC0T
 nMK/D5+7HaABwJQAt7s14LikEdkUSgNz0ULjt86xNmfD/cfI5rNKtluEddwHcOxwG7z4+jHHH
 EUbOZCP2+vwp/+TAQ7dbp4lSi78Za7/giBvBLtF0j0Pkkd1ZA25XANu6Gpn0TwXubv45S0azK
 4b4lJsyyLjBitwSRAhHOv4k63IuJVHT2HZ6ClhBVmi3kudCV1XrqrUxxRM3uke+8FWNnFuQZc
 /cq6RutFkrApr4u80owmOQuiKvjP1yYtBVK2rhPcezNBljfXPJsOYxg6Gyinz+BPIy8wa2SkV
 15ofcF8fT1/B21Dsimh9k/63PFVnkLBpsAGkL5Oi7lID0Y9kxERwK68910lrvyuqx8rpgi/0K
 FouU4RmyHGHLuDlGm5ThuuKWxGWwcFbCiXFNTWHIOeZ+SxUG+8CiVUoiP5prhg8uTHbf/grez
 ayGkQvGfx3xAVS8pwPxej5577cKIkK+tKT7pVFLh74lddpt7GoR+kDW2SFoMxZpyznuGm+q4L
 3D8d9goiwMJQMIQeyggJq89JjuAJSd+98ogCj14znWbp8VOon9pRT3uixXMvBIW9NdipNsNMR
 G9vdGVA63FJnafeAHJPqUSMfRGJGdE5b+x+CWf1RfMK2fVGFbREvNtpjcpjlSvlKVcngmOCLf
 /G1p9IALm5lAbD1B
X-Spam-Status: No, score=-96.7 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_MSPIKE_H5,
 RCVD_IN_MSPIKE_WL, SPF_FAIL, SPF_HELO_NONE, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Wed, 02 Mar 2022 21:04:35 -0000

On Mar  2 21:35, Corinna Vinschen wrote:
> On Mar  2 12:45, Brian Inglis wrote:
> > On 2022-03-02 01:25, Corinna Vinschen wrote:
> > > Hi Brian,
> > > 
> > > On Mar  1 13:20, Brian Inglis wrote:
> > > > Interested in a patch for sysconf.cc to return:
> > > > 
> > > >       _SC_TZNAME_MAX => TZNAME_MAX and
> > > > _SC_MONOTONIC_CLOCK => _POSIX_MONOTONIC_CLOCK?
> > > 
> > > not sure I understand the question.  Both are already implemented.
> > > 
> > >    $ getconf -a | egrep '(TZNAME_MAX|MONOTONIC_CLOCK)'
> > >    _POSIX_TZNAME_MAX                   6
> > >    TZNAME_MAX                          undefined
> > >    _POSIX_MONOTONIC_CLOCK              200809
> > 
> > Sorry, must have been looking at very *OLD* version online, as
> > _SC_CLOCK_SELECTION and _SC_MONOTONIC_CLOCK were not defined.
> > 
> > Why did you not define _SC_TZNAME_MAX => _POSIX_TZNAME_MAX when you tweaked
> > it?
> 
> Because it's wrong.  _POSIX_TZNAME_MAX is just a minimum value required
> by POSIX, not the correct value to return for TZNAME_MAX.
> 
> > My rereading of the man and POSIX pages leads me to believe that for all
> > known values of _SC_... the entries now showing {nsup, {c:0}} should be
> > {cons, {c:-1L}} supported but undefined, and only out of range values for
> > the parameter should be treated as {nsup, {c:-1L}}?
> 
> These are really not undefined, but not supported on Cygwin.  That's
> why they return with EINVAL.  I see what you mean, though, let me think
> about it.

Yep, I guess you're right.  I compared this with what Linux returns
for the unsupported tracing options.  See commits cf00bba99a61 and
fcec4830abf0.


Thanks,
Corinna
