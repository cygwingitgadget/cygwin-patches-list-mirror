Return-Path: <cygwin-patches-return-3146-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 17849 invoked by alias); 10 Nov 2002 00:52:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17800 invoked from network); 10 Nov 2002 00:52:08 -0000
Date: Sat, 09 Nov 2002 16:52:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: FIONREAD for pipes implementation.
Message-ID: <20021110005214.GA24114@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <015501c28785$48c64a30$0201a8c0@sos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <015501c28785$48c64a30$0201a8c0@sos>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2002-q4/txt/msg00097.txt.bz2

On Fri, Nov 08, 2002 at 07:16:41PM -0500, Sergey Okhapkin wrote:
>The patch implements ioctl(fd, FIONREAD, ...) call when fd is a pipe.
>
>2002-11-06  Sergey Okhapkin  <sos@prospect.com.ru>
>
>        * fhandler.h (class fhandler_pipe): New ioctl() method.
>        * pipe.cc (fhandler_pipe::ioctl): New.

Applied.  Thanks.

cgf
