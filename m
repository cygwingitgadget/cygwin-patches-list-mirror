Return-Path: <cygwin-patches-return-2607-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 30667 invoked by alias); 5 Jul 2002 17:06:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30649 invoked from network); 5 Jul 2002 17:06:07 -0000
Date: Fri, 05 Jul 2002 10:06:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: --enable-auto-import extension
Message-ID: <20020705170621.GE30783@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1212929671.20020628141818@logos-m.ru> <3D1D08A1.9070505@ece.gatech.edu> <180259441557.20020701104656@logos-m.ru> <3D20C981.8020407@ece.gatech.edu> <903891375.20020702193614@logos-m.ru> <14464996970.20020703123443@logos-m.ru> <20020704163021.GA27886@redhat.com> <15690890433.20020705113658@logos-m.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15690890433.20020705113658@logos-m.ru>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q3/txt/msg00055.txt.bz2

On Fri, Jul 05, 2002 at 11:36:58AM +0400, egor duda wrote:
>Hi!
>
>Thursday, 04 July, 2002 Christopher Faylor cgf@redhat.com wrote:
>
>CF> On Wed, Jul 03, 2002 at 12:34:43PM +0400, egor duda wrote:
>>>Attached is a patch to add support runtime pseudo-relocations in
>>>cygwin once/if binutils with support for them are released.
>
>CF> Is there some reason why this has to be linked into the application and
>CF> is not run from the DLL?  It looks like you'd need to get the
>CF> _image_base__ variable into the DLL somehow but we should be able to do
>CF> that in _cygwin_crt0_common if there is no other way to get this.
>
>We have to make sure that we get application's, not cygwin1.dll's
>_image_base__, __RUNTIME_PSEUDO_RELOC_LIST__, and
>__RUNTIME_PSEUDO_RELOC_LIST_END__. Actually, part that is linked into
>application is doing just this -- gets application's _image_base__,
>RPRL and RPRLE and pass them to dll.

Yes, I understand that.  This is no different from getting the applications
ctor list or the application's environment table or the application's data
segment or...  See _cygwin_crt0_common.cc.

>Actually, dll's client may be another dll. I haven't tested it yet.
>Doess _image_base__ for, say, cygintl.dll get updated when/if cygintl.dll
>is rebased at load time?

Dunno.

>CF> I think it makes sense to do as little as possible in the library stub
>CF> code and as much as possible in the DLL so moving the call to
>CF> _pei386_runtime_relocator seems like a good thing.
>
>CF> Btw, could you give a paragraph summary of what this code does?  I
>CF> haven't been following the binutils discussion that closely.  Sounds
>CF> very interesting though...
>
>There is a problem with auto-import when client has a reference to data
>object in dll with some offset. For instance, dll exports _foo_struct
>and client code contains 'x = _foo_struct.bar'. In this case compiler
>generates a relocation with base symbol _foo_struct and addend equal
>to offset of field "bar" in the structure. ld (when doing static
>linking) and, say, linux ld.so, can handle such relocations, while
>Microsoft's loader can't. So, the only option so far was to change
>application code to get rid of relocations with non-zero addends. But
>this is not always possible -- such relocations may be generated
>implicitly. For instance, c++ exception handling emits a record which
>contains a pointer to "type info". Pointer to type info is 'vtable +
>8'. If vtable is imported from dll, we can't 'auto-import' this data
>reference in client code.
>
>So, to work around this limitation of Microsoft's loader we can add
>some runtime support for relocations with non-zero addends. ld
>generates a vector of "pseudo-relocations" for each such reference in
>client code, and then runtime environment perform necessary fixups at
>program startup. Additionally, to make sure that runtime environment
>supports such "pseudo-relocations" at link-time, iff at least one such
>relocation is generated, it also creates reference to symbol
>_pei386_runtime_relocator. In case of linking new dll client with old
>runtime we'll get error at link-time -- not some strange effects of
>some references in client code are missing needed addends.

Thanks for the explanation.

cgf
