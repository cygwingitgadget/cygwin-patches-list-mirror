Return-Path: <cygwin-patches-return-1956-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 11207 invoked by alias); 7 Mar 2002 03:04:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11169 invoked from network); 7 Mar 2002 03:04:03 -0000
Date: Thu, 07 Mar 2002 06:36:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: cygpath copyright/version patch
Message-ID: <20020307030403.GA13107@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20020227162528.GA2205@redhat.com> <20020227205634.45738.qmail@web20003.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020227205634.45738.qmail@web20003.mail.yahoo.com>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q1/txt/msg00313.txt.bz2

On Wed, Feb 27, 2002 at 12:56:34PM -0800, Joshua Daniel Franklin wrote:
>Changelog:
>
>2002-02-27 Joshua Daniel Franklin <joshuadfranklin@yahoo.com>
>
>* cygpath.cc (print_version): New function.
>(main): Accommodate new version function. Initialize 'o' to prevent warning.

Applied with some minor tweaks.

I also ran indent over the file.  It had accumulated a strange mishmash of
GNU and non-GNU formatting.

cgf
