Return-Path: <cygwin-patches-return-4533-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20356 invoked by alias); 23 Jan 2004 15:22:51 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 20347 invoked from network); 23 Jan 2004 15:22:51 -0000
Date: Fri, 23 Jan 2004 15:22:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Fix write deadlock with streaming serial devices
Message-ID: <20040123152251.GE10708@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.GSO.4.58.0401221638310.17483@eos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0401221638310.17483@eos>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q1/txt/msg00023.txt.bz2

On Thu, Jan 22, 2004 at 05:07:38PM -0600, Brian Ford wrote:
>2004-01-22  Brian Ford  <ford@vss.fsi.com>
>
>	* fhandler_serial.cc (fhandler_serial::raw_write): Prevent a
>	deadlock when the input buffer overflows.
>	(fhandler_serial::raw_read): Correct to print the actual error
>	and only call PurgeComm when necessary.
>
>+          DWORD ev;
>+          if (!ClearCommError (get_handle (), &ev, NULL)) goto err;
>+          if (ev) termios_printf ("error detected %x", ev);

Applied with the above two minor non-GNU formatting problems corrected.

Thanks.

cgf
