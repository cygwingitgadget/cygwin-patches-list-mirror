Return-Path: <cygwin-patches-return-2499-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 22318 invoked by alias); 24 Jun 2002 02:25:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22284 invoked from network); 24 Jun 2002 02:25:30 -0000
Date: Sun, 23 Jun 2002 19:37:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: S_IFSOCK setting
Message-ID: <20020624022616.GA18324@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <040201c219f8$6f3233a0$6132bc3e@BABEL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <040201c219f8$6f3233a0$6132bc3e@BABEL>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q2/txt/msg00482.txt.bz2

On Sat, Jun 22, 2002 at 03:23:52PM +0100, Conrad Scott wrote:
>2002-06-22  Conrad Scott  <conrad.scott@dsl.pipex.com>
>
>	* fhandler.cc (fhandler_base::fstat): Set S_IFIFO for pipes.
>	* fhandler_socket.cc (fhandler_socket.cc::fstat): Set S_IFSOCK.

Doh.  I knew that something was bugging me as I was releasing 1.3.11.
This patch was it.  I meant to include it.

Oh well.  It's in now.

Thanks!

cgf
