Return-Path: <cygwin-patches-return-2890-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 13529 invoked by alias); 30 Aug 2002 14:51:30 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13515 invoked from network); 30 Aug 2002 14:51:30 -0000
Date: Fri, 30 Aug 2002 07:51:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Base readv/writev patch
Message-ID: <20020830145127.GD1218@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <000101c24f8e$1a656c40$6132bc3e@BABEL> <20020830151128.I5475@cygbert.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020830151128.I5475@cygbert.vinschen.de>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q3/txt/msg00338.txt.bz2

On Fri, Aug 30, 2002 at 03:11:28PM +0200, Corinna Vinschen wrote:
>On Thu, Aug 29, 2002 at 01:06:14AM +0100, Conrad Scott wrote:
>> Attached is the base part of the readv/writev patch I sent in
>> yesterday, i.e. just the generic syscall.cc and fhandler_base
>> parts, w/o any of the socket changes.  Otherwise unchanged from
>> before except for the expunging of those darn new-fangled C++ cast
>> woojits :-)
>
>I had another look into this patch and it looks good, IMHO.
>But I think Chris should give the final go here.  I'm going
>to work under that cygwin dll for now.

It's ok with me.  Feel free to check it in, Conrad.

cgf
