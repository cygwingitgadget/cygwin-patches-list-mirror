Return-Path: <cygwin-patches-return-1976-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 14002 invoked by alias); 11 Mar 2002 18:35:18 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13977 invoked from network); 11 Mar 2002 18:35:18 -0000
Date: Mon, 11 Mar 2002 12:30:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: (small) kill.cc patch
Message-ID: <20020311183519.GA18591@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20020311181627.8971.qmail@web20001.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020311181627.8971.qmail@web20001.mail.yahoo.com>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q1/txt/msg00333.txt.bz2

On Mon, Mar 11, 2002 at 10:16:27AM -0800, Joshua Daniel Franklin wrote:
>Here is a patch that moves the functions in kill.cc to the top.
>That's all it does.
>
>This is for consistency with the other utils.
>
>2001-03-11 Joshua Daniel Franklin <joshuadfranklin@yahoo.com>
>* kill.cc (usage) move to top of file
>          (getsig) ditto
>          (forcekill) ditto

I've checked this in, with ChangeLog fixes.  Please use my changes as
a guide for how the ChangeLog should be formatted.

cgf
