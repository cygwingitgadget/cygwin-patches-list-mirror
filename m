Return-Path: <cygwin-patches-return-1533-listarch-cygwin-patches=sourceware.cygnus.com@sources.redhat.com>
Received: (qmail 20311 invoked by alias); 27 Nov 2001 23:09:36 -0000
Mailing-List: contact cygwin-patches-help@sourceware.cygnus.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@sources.redhat.com>
List-Post: <mailto:cygwin-patches@sources.redhat.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@sources.redhat.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@sources.redhat.com
Received: (qmail 20260 invoked from network); 27 Nov 2001 23:09:31 -0000
Date: Sun, 21 Oct 2001 16:20:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] setup.exe: Stop NetIO_HTTP from treating entire stream as a  header
Message-ID: <20011127230925.GA5830@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3C035977.BF151D0A@syntrex.com> <000601c17772$7c5ecfd0$2101a8c0@d8rc020b> <20011127184223.GA24028@redhat.com> <1006899141.2048.2.camel@lifelesswks>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1006899141.2048.2.camel@lifelesswks>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2001-q4/txt/msg00065.txt.bz2

On Wed, Nov 28, 2001 at 09:12:20AM +1100, Robert Collins wrote:
>On Wed, 2001-11-28 at 05:42, Christopher Faylor wrote:
>
>> >Ah, better yet.  Jeez you guys are clever ;-).  But how about we make it:
>> >
>> >	while (((l = s->gets ()) != 0) && (*l != '\0'))
>> >
>> >in the interest of making it a bit more self-documenting?
>> 
>> Actually, how about not using != 0.  Use NULL in this context.
>> 
>> I don't think that *l is hard to understand, fwiw.
>
>I think *l is ok. As for 0 vs NULL, in C++ NULL is deprecated, 0 is the
>correct test for an invalid pointer.

References?  A simple google search for 'NULL C++ deprecated' didn't
unearth this information.

Regardless, I strenuously disagree with this.  It certainly is not
deprecated in the Cygwin DLL.

cgf
