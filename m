Return-Path: <cygwin-patches-return-4033-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4879 invoked by alias); 2 Aug 2003 14:12:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4870 invoked from network); 2 Aug 2003 14:12:48 -0000
Date: Sat, 02 Aug 2003 14:12:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] patch.cc: cygdrive_getmntent () - Unify behaviour with fhandler_cygdrive
Message-ID: <20030802141248.GB16831@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <17997.1059825201@www3.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17997.1059825201@www3.gmx.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00049.txt.bz2

On Sat, Aug 02, 2003 at 01:53:21PM +0200, Pavel Tsekov wrote:
>Here is a simple patch which makes the behaviour of getmntent ()
>consistent with the one of fhandler_cygdrive.

The reason this is there is to avoid long delays in mount table
listings.

cgf
