Return-Path: <cygwin-patches-return-4642-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8032 invoked by alias); 30 Mar 2004 16:21:28 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7971 invoked from network); 30 Mar 2004 16:21:21 -0000
Date: Tue, 30 Mar 2004 16:21:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Dr.Volker.Zell@oracle.com: Re: uxterm from xterm-185-3 and xfontsel crashing when running under cygserver support]
Message-ID: <20040330162118.GA8138@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <15169.1080650540@www37.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15169.1080650540@www37.gmx.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q1/txt/msg00132.txt.bz2

On Tue, Mar 30, 2004 at 02:42:20PM +0200, Thomas Pfaff wrote:
>1. The thread which is started by the service control manager must be
>initiallized, for example in the first get_tls_self_pointer call. Chris has made
>some changes to TLS, i do not know if _my_tls  can be used for a thread that is
>created from outside.

If _my_tls couldn't be used for a thread that is not created by pthread,
then cygrunsrv would be dying more spectactularly and earlier since
_my_tls is use everywhere.

_my_tls is not related to pthreads.

cgf
