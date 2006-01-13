Return-Path: <cygwin-patches-return-5709-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1391 invoked by alias); 13 Jan 2006 03:57:33 -0000
Received: (qmail 1381 invoked by uid 22791); 13 Jan 2006 03:57:32 -0000
X-Spam-Check-By: sourceware.org
Received: from zproxy.gmail.com (HELO zproxy.gmail.com) (64.233.162.203)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 13 Jan 2006 03:57:29 +0000
Received: by zproxy.gmail.com with SMTP id s18so501583nze         for <cygwin-patches@cygwin.com>; Thu, 12 Jan 2006 19:57:28 -0800 (PST)
Received: by 10.36.4.18 with SMTP id 18mr2298343nzd;         Thu, 12 Jan 2006 19:57:27 -0800 (PST)
Received: by 10.36.18.12 with HTTP; Thu, 12 Jan 2006 19:57:27 -0800 (PST)
Message-ID: <cb51e2e0601121957p711594fexdf2a87e4395e3059@mail.gmail.com>
Date: Fri, 13 Jan 2006 03:57:00 -0000
From: Joshua Daniel Franklin <joshuadfranklin@gmail.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Proposed clarification of the snapshot installation FAQ
In-Reply-To: <Pine.GSO.4.63.0601112136461.9317@access1.cims.nyu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
References: <dpu1ks$i0a$1@sea.gmane.org> <43C32DA9.2070900@cygwin.com> 	 <dpvba1$i83$1@sea.gmane.org> <43C3F412.1010008@cygwin.com> 	 <dq3d00$4o7$1@sea.gmane.org> 	 <Pine.GSO.4.63.0601111200110.9317@access1.cims.nyu.edu> 	 <dq3h09$k5o$1@sea.gmane.org> 	 <Pine.GSO.4.63.0601112136461.9317@access1.cims.nyu.edu>
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q1/txt/msg00018.txt.bz2

On 1/11/06, Igor Peshansky wrote:
> As mentioned in <http://cygwin.com/ml/cygwin/2006-01/msg00537.html>,
> here's a patch to the FAQ to clarify the section on installing snapshots.
> I didn't know whether the various *.texinfo files are still used, so I
> ported the modifications there as well, just in case.

Applied to faq-setup.xml (the texinfo files are no longer used... I suppose=
 I
should remove them). It would be nice to have a sample batch file that auto=
mated
the cygwin1.dll replacement, too.
