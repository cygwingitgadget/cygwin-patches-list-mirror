Return-Path: <cygwin-patches-return-2600-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 30402 invoked by alias); 4 Jul 2002 16:30:10 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30387 invoked from network); 4 Jul 2002 16:30:08 -0000
Date: Thu, 04 Jul 2002 09:30:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: --enable-auto-import extension
Message-ID: <20020704163021.GA27886@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1212929671.20020628141818@logos-m.ru> <3D1D08A1.9070505@ece.gatech.edu> <180259441557.20020701104656@logos-m.ru> <3D20C981.8020407@ece.gatech.edu> <903891375.20020702193614@logos-m.ru> <14464996970.20020703123443@logos-m.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14464996970.20020703123443@logos-m.ru>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q3/txt/msg00048.txt.bz2

On Wed, Jul 03, 2002 at 12:34:43PM +0400, egor duda wrote:
>Hi!
>
>Tuesday, 02 July, 2002 egor duda deo@logos-m.ru wrote:
>
>ed> Ok, i've finalized patch and test.
>
>Attached is a patch to add support runtime pseudo-relocations in
>cygwin once/if binutils with support for them are released.

Is there some reason why this has to be linked into the application and
is not run from the DLL?  It looks like you'd need to get the
_image_base__ variable into the DLL somehow but we should be able to do
that in _cygwin_crt0_common if there is no other way to get this.

I think it makes sense to do as little as possible in the library stub
code and as much as possible in the DLL so moving the call to
_pei386_runtime_relocator seems like a good thing.

Btw, could you give a paragraph summary of what this code does?  I
haven't been following the binutils discussion that closely.  Sounds
very interesting though...

cgf
