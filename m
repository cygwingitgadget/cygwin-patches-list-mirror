Return-Path: <cygwin-patches-return-3292-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8476 invoked by alias); 9 Dec 2002 22:49:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8462 invoked from network); 9 Dec 2002 22:49:44 -0000
Date: Mon, 09 Dec 2002 14:49:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: --enable-runtime-pseudo-reloc support in cygwin, take 3.
Message-ID: <20021209225053.GA6419@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20021119072016.23A231BF36@redhat.com> <3577371564.20021119120659@logos-m.ru> <1451205547776.20021202133024@logos-m.ru> <20021202175006.GC21442@redhat.com> <19973816953.20021203124546@logos-m.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19973816953.20021203124546@logos-m.ru>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2002-q4/txt/msg00243.txt.bz2

On Tue, Dec 03, 2002 at 12:45:46PM +0300, egor duda wrote:
>Monday, 02 December, 2002 Christopher Faylor cgf@redhat.com wrote:
>CF> On Mon, Dec 02, 2002 at 01:30:24PM +0300, egor duda wrote:
>>>2002-12-02  Egor Duda <deo@logos-m.ru>
>>>
>>>        * cygwin/lib/pseudo-reloc.c: New file.
>>>        * cygwin/cygwin.sc: Add symbols to handle runtime pseudo-relocs.
>>>        * cygwin/lib/_cygwin_crt0_common.cc: Perform pseudo-relocs during
>>>        initialization of cygwin binary (.exe or .dll).
>
>CF> I'm rapidly approaching the I-don't-care-anymore state for this but I am
>CF> not clear on why we need to add the changes to cygwin.sc.  This is for people
>CF> who want to link the cygwin DLL without using the appropriate header files
>CF> which label things as __declspec(dllexport) or using the appropriate libcygwin.a,
>CF> right?  Why should that matter?
>
>Yes, you're right. This part is not needed. It's probably been left
>out from the "experimental" phase when i tried different ways to
>handle pseudo-relocs. Here's the updated one.

Our lawyer has informed me that PD is ok on a limited basis, so I've checked
this in, at long last.

Thanks everyone for your patience as we hashed this out.

cgf
