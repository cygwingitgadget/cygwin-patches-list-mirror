Return-Path: <cygwin-patches-return-3427-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19059 invoked by alias); 20 Jan 2003 02:49:27 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18993 invoked from network); 20 Jan 2003 02:49:26 -0000
Date: Mon, 20 Jan 2003 02:49:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: etc_changed, passwd & group
Message-ID: <20030120025041.GA774@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030117233612.007ed390@mail.attbi.com> <20030120024000.GA452@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030120024000.GA452@redhat.com>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2003-q1/txt/msg00076.txt.bz2

On Sun, Jan 19, 2003 at 09:40:01PM -0500, Christopher Faylor wrote:
>
>For the "Novell case", I explicitly check the creation time of the file
>every time.  It may be slower but at least it makes cygwin behavior consistent
>regardless of whether the FS.
               XXXXXXX

>I also a debug_printf showing how many lines were read in in pwdgrp::load
      added

Cheesh.

cgf
