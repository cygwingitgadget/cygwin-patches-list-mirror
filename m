Return-Path: <cygwin-patches-return-5507-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29067 invoked by alias); 5 Jun 2005 00:54:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29052 invoked by uid 22791); 5 Jun 2005 00:53:58 -0000
Received: from rproxy.gmail.com (HELO rproxy.gmail.com) (64.233.170.193)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Sun, 05 Jun 2005 00:53:58 +0000
Received: by rproxy.gmail.com with SMTP id r35so866327rna
        for <cygwin-patches@cygwin.com>; Sat, 04 Jun 2005 17:53:56 -0700 (PDT)
Received: by 10.38.153.45 with SMTP id a45mr1832301rne;
        Sat, 04 Jun 2005 17:53:56 -0700 (PDT)
Received: by 10.38.76.64 with HTTP; Sat, 4 Jun 2005 17:53:56 -0700 (PDT)
Message-ID: <cb51e2e050604175349d5e698@mail.gmail.com>
Date: Sun, 05 Jun 2005 00:54:00 -0000
From: Joshua Daniel Franklin <joshuadfranklin@gmail.com>
Reply-To: Joshua Daniel Franklin <joshuadfranklin@gmail.com>
To: Max Kaehn <slothman@electric-cloud.com>
Subject: Re: [Patch] Loading cygwin1.dll from MinGW and MSVC
Cc: cygwin-patches@cygwin.com
In-Reply-To: <1117839489.5031.23.camel@fulgurite>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
References: <1117839489.5031.23.camel@fulgurite>
X-SW-Source: 2005-q2/txt/msg00103.txt.bz2

On 6/3/05, Max Kaehn wrote:
> This patch contains the changes to make it possible to dynamically load
> cygwin1.dll from MinGW and MSVC applications.  The changes to dcrt0.cc are
> minimal and only affect cygwin_dll_init().  I've also added a MinGW test
> program to testsuite and a FAQ so people will be able to locate the
> test program easily.

Assuming the code patches are fine, instead of a new section could we just=
=20
add your FAQ hint to "How do I link against `cygwin1.dll' with Visual Studi=
o?"
<http://cygwin.com/faq/faq_toc.html#TOC102>
The title could be changed to something like "How do I use `cygwin1.dll' wi=
th=20
MinGW or Visual Studio?"

I'm a little torn since I'm not sure this is actually frequently asked but =
it's=20
certainly good to have the info. Ideally I can put it in the User's Guide.
