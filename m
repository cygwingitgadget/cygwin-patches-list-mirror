Return-Path: <cygwin-patches-return-3184-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15231 invoked by alias); 15 Nov 2002 16:10:18 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15221 invoked from network); 15 Nov 2002 16:10:15 -0000
Date: Fri, 15 Nov 2002 08:10:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: cygwin part of pseudo-relocs patch
Message-ID: <20021115161039.GA2887@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <17051818150.20020903103820@logos-m.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17051818150.20020903103820@logos-m.ru>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2002-q4/txt/msg00135.txt.bz2

On Tue, Sep 03, 2002 at 10:38:20AM +0400, egor duda wrote:
>This is an updated cygwin part of pseudo-relocs patch.  Relocations are
>performed inside of cygwin1.dll, as Chris suggested, and it seems to
>work ok in case of one dll referencing another one.  After new binutils
>package is released, it can go into cygwin release.

Just to get a head start on reviewing this, I wanted add some more
comments.

I can see code in dll_crt0_1 being called for handling relocs.  Is it
your intent that every new DLL will have to specifically call
_pei386_runtime_relocator?

I can see that over ld-land you are generating an undefined reference for
this symbol if the --enable-runtime-pseudo-reloc switch is used.  Is this
just to ensure that there is an error message when linking with a new
version of binutils but an older version of a dll that's being built?

I was thinking that a call to this code would live in the application
but obviously that's wrong.  It has to live in the DLL.  Wouldn't that
mean that it should be added somehow to _cygwin_dll_entry
winsup/cygwin/include/cygwin/cygwin_dll.h ?

cgf
