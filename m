Return-Path: <cygwin-patches-return-2267-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 24053 invoked by alias); 30 May 2002 07:56:55 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23981 invoked from network); 30 May 2002 07:56:53 -0000
Date: Thu, 30 May 2002 00:56:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: Cleanup of ntdll.h
Message-ID: <20020530095651.Y30892@cygbert.vinschen.de>
Mail-Followup-To: cygpatch <cygwin-patches@cygwin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q2/txt/msg00250.txt.bz2

Hi,

I've cleaned up the usage of NTDLL.DLL functions slightly.  For some
reason the function ZwQueryInformationProcess has been additionally
defined even though NtQueryInformationProcess was already available.
Additional functions have been defined as ZwXXX while formerly
already defined functions did use the NtXXX style.

I changed that now so that all functions are called with Nt prefix.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
