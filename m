Return-Path: <cygwin-patches-return-3841-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4707 invoked by alias); 30 Apr 2003 14:05:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4698 invoked from network); 30 Apr 2003 14:05:04 -0000
Date: Wed, 30 Apr 2003 14:05:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] revert finline changes to Makefile.in
Message-ID: <20030430140557.GF18584@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.WNT.4.44.0304301010290.357-200000@algeria.intern.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.WNT.4.44.0304301010290.357-200000@algeria.intern.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q2/txt/msg00068.txt.bz2

On Wed, Apr 30, 2003 at 10:20:39AM +0200, Thomas Pfaff wrote:
>I would like to revert my patch to Makefile.in to enable
>finline-functions optimization.  This change to Makefile.in is not
>obvious to use.  A better way to enable finline-functions is to set
>CXXFLAGS properly, for example:

Ok.

cgf
