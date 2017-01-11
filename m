Return-Path: <cygwin-patches-return-8683-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 100038 invoked by alias); 11 Jan 2017 19:48:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 100026 invoked by uid 89); 11 Jan 2017 19:48:52 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.1 required=5.0 tests=BAYES_00,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_SORBS_SPAM,SPF_PASS autolearn=ham version=3.3.2 spammy=ciao, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: mout.gmx.net
Received: from mout.gmx.net (HELO mout.gmx.net) (212.227.15.15) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 11 Jan 2017 19:48:50 +0000
Received: from virtualbox ([213.133.108.164]) by mail.gmx.com (mrgmx001 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LZiLk-1csmcl34ua-00lUV7 for <cygwin-patches@cygwin.com>; Wed, 11 Jan 2017 20:48:47 +0100
Date: Wed, 11 Jan 2017 19:48:00 -0000
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] FAST_CWD: adjust the initial search scope
In-Reply-To: <20170111160303.GA23119@calimero.vinschen.de>
Message-ID: <alpine.DEB.2.20.1701112048200.3469@virtualbox>
References: <5b4e3785c193feb56fa31eef637db2641e69eefd.1484140876.git.johannes.schindelin@gmx.de> <20170111160303.GA23119@calimero.vinschen.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-UI-Out-Filterresults: notjunk:1;V01:K0:8P2hHnYoNYQ=:OLI3ngYCS3QEGA5A3KM9L0 WrJ8voeaGOyvClnYaRsuCOg/Id6fgt2Eg78kxtBlPw8iVUWvY7M5WfPttmGzeoxC86/xELPSe EARm+zM7+B35oF0gj2jxDVyA4MhcD7/aHoWjcWVmiUTEWSFgdhRHmqs7yiHG2I/pRYleIUzk5 /XyRtGLu3/AMMqPEh3RxQnLqZql3ixHrkZQGvhKbN9vPWGmPiPAKbOZvFRLfB8KSX9ArOaCxf QPaJvLy2TGy5+iH14sXWyAvLLDqwTQ6OjE+5cxh7eOOej7Sl0+vMLs7e6MBH9xaW8VG4dtBSB NXyKejNwYybMiG6I+aygiL6qLgOZCSGlXomK6VsK3ckwCcT7hFVCsAXBcHQOD/9Kn0pN2FbLV JqqPGthjdy9By46N59ZfqnqfkLFXMAuqOifLNlbYExOZ+7owavLiLcddjOUJmGVYqaFhHhK4e /1XhBNGnD4u11hNSdf/iAgRfDuDJdR2meoFWstMAFDVd377/nbrJQIPo7SyCg8/czPBJOAE9A MtDZr9iSDKW80NPjfYeiu+9DtL0KHU7kg0eSm1J6Jn8TOcyE/oPnsmT2mNtSe1h3olVc7DiYO cvVOuh2cUC+Nx2fRgwbXPbYOzwlDy9Xpm6GZ3WY8FYYFC/a0a9zHn56VFH6XzGP0/uKBOU6Rs PWRrhJ75wMbGJCDHqaZY+l45rDXfoJrw0V/DSDfBT8XzW4Do+qJlg8MTYhnKK2eYDiQ+KU1e8 GqAaf1yvZxw4wk5oMBqFi4z0tvTym+TtETJkRFQhWXKATDrEbFhyyb6+s0EBnaBAzZ8+4A5PF 0FEKZiNgo+zFa/Otvtyp7USdzBs1w==
X-IsSubscribed: yes
X-SW-Source: 2017-q1/txt/msg00024.txt.bz2

Hi Corinna,

On Wed, 11 Jan 2017, Corinna Vinschen wrote:

> On Jan 11 14:21, Johannes Schindelin wrote:
> > A *very* recent Windows build adds more code to the preamble of
> > RtlGetCurrentDirectory_U() so that the previous heuristic failed to
> > find the call to the locking routine.
> > 
> > This only affects the 64-bit version of ntdll, where the 0xe8 byte is
> > now found at offset 40, not the 32-bit version. However, let's just
> > double the area we search for said byte for good measure.
> 
> any chance to convince the powers that be to open up access to this
> datastructures without such hacky means?

I try my best.

Ciao,
Johannes
