Return-Path: <cygwin-patches-return-3262-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19216 invoked by alias); 2 Dec 2002 15:59:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19197 invoked from network); 2 Dec 2002 15:59:36 -0000
Date: Mon, 02 Dec 2002 07:59:00 -0000
From: egor duda <deo@logos-m.ru>
Reply-To: egor duda <cygwin-patches@cygwin.com>
Organization: deo
X-Priority: 3 (Normal)
Message-ID: <1879834601.20021202185923@logos-m.ru>
To: cygwin-patches@cygwin.com
Subject: Re: --enable-runtime-pseudo-reloc support in cygwin, take 3.
In-Reply-To: <20021202154220.GB19575@redhat.com>
References: <20021119072016.23A231BF36@redhat.com>
 <3577371564.20021119120659@logos-m.ru>
 <1451205547776.20021202133024@logos-m.ru>
 <1551207829817.20021202140826@logos-m.ru> <20021202154220.GB19575@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q4/txt/msg00213.txt.bz2

Hi!

Monday, 02 December, 2002 Christopher Faylor cgf@redhat.com wrote:

CF> On Mon, Dec 02, 2002 at 02:08:26PM +0300, egor duda wrote:
>>Hi!
>>
>>Monday, 02 December, 2002 egor duda deo@logos-m.ru wrote:
>>
>>ed> 2002-12-02  Egor Duda <deo@logos-m.ru>
>>ed>         * cygwin/lib/pseudo-reloc.c: New file.
>>
>>I guess i should put it to the public domain, so that mingw folks can
>>also use it.

CF> I'm not sure that public domain is going to work with the cygwin license.

IANAL, but i can't see why not. As far as i understand, you can
incorporate public domain code to whichever project you want,
retaining a copyright, and then distribute everything under cygwin, or
commercial or whatever license.

Doug Lea's malloc() is in public domain, for instance. And IIRC it's
now used by cygwin as a default malloc routine.

CF> I'm also not sure that this is a great idea for mingw, which is supposed
CF> to be a pretty generic windows environment, AFAIK.  If mingw starts
CF> creating fancy new dlls then that sort of strays from their core
CF> purpose, IMO.

Why? It's obvious for mingw people to implement, say, openssl library
as a dll. It exports several data items. Mingw version of ssl.dll
would export them. Now, imagine that someone writes an application
which uses data items exported from ssl.dll and compiles in with
mingw. If _pei386_runtime_relocator is linked within application and
called at startup, then all references from foo.exe to ssl.dll which
have to be fixed up, will be.

The core idea of _pei386_runtime_relocator() is to be generic, as long
as PE on i386 is concerned, hence the name. For instance, i don't see
much difficulties for interix to use it too.

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19
