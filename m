Return-Path: <cygwin-patches-return-7143-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13519 invoked by alias); 20 Dec 2010 21:33:41 -0000
Received: (qmail 13501 invoked by uid 22791); 20 Dec 2010 21:33:38 -0000
X-SWARE-Spam-Status: No, hits=-1.1 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,T_RP_MATCHES_RCVD,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from mailout01.t-online.de (HELO mailout01.t-online.de) (194.25.134.80)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 20 Dec 2010 21:33:32 +0000
Received: from fwd09.aul.t-online.de (fwd09.aul.t-online.de )	by mailout01.t-online.de with smtp 	id 1PUnMG-0007fr-3s; Mon, 20 Dec 2010 22:33:28 +0100
Received: from [192.168.2.100] (Vr7TQ4ZSohc0CaGXFlXRXlHK8t4bhHl0UBqeg2zAoCQ30nVH57j79Lgif5YNQIpgzf@[79.224.119.144]) by fwd09.aul.t-online.de	with esmtp id 1PUnMD-0KcOMy0; Mon, 20 Dec 2010 22:33:25 +0100
Message-ID: <4D0FCBA5.5020300@t-online.de>
Date: Wed, 22 Dec 2010 13:31:00 -0000
From: Christian Franke <Christian.Franke@t-online.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.1.15) Gecko/20101027 SeaMonkey/2.0.10
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Ensure that the default ACL contains the standard entries
References: <4D02A41C.8030406@t-online.de> <20101211204653.GA26611@calimero.vinschen.de> <4D07E02A.2020202@t-online.de> <20101215141149.GW10566@calimero.vinschen.de> <4D090D12.6020407@t-online.de> <20101216111024.GX10566@calimero.vinschen.de>
In-Reply-To: <20101216111024.GX10566@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q4/txt/msg00022.txt.bz2

Hi Corinna,

Corinna Vinschen wrote:
> Hi Christian,
>
> On Dec 15 19:46, Christian Franke wrote:
> ...
>> BTW: Are there any long term plans to actually implement the acl "mask" ?
>> Should be possible by mapping the "mask" restrictions to deny acl
>> entries for each named entry:
>>      
> There are no such plans, but that doesn't mean I wouldn't take patches
> which implement this.  In fact I would be *very* happy to get patches
> which improve ACL handling, and I'm not finicky in terms of the type
> of enhancement.  Various ideas come to mind:
>
> - Fix acl(2) by handling deny ACEs at all.
>
> - Implement the POSIX 1003.1e functions (maybe simply in terms of
>    the existing Solaris API).
>
> - Add missing Solaris ACL functions (acl_get, facl_get, acl_set, facl_set,
>    acl_fromtext, acl_totext, acl_free, acl_strip, acl_trivial).
>
> - Add Solaris NFSv4 ACLs, which, coincidentally, are almost equivalent
>    to Windows ACLs.  This would work nicely for NTFS ACLs, of course.
>    See http://docs.sun.com/app/docs/doc/819-2252/acl-5?l=en&a=view
>
>    

Yes NFSv4 ACLs would make much sense. Coreutils copy-acl.c apparently 
supports these if available (It copies first POSIX ACL and then NTFS 
ACL). This may allow that 'cp -a source dest' keeps the NTFS ACL unchanged.


> - Last but not least:  Actually handle "mask".
>
> Adding deny entries which correspond to the mask value sounds like an
> interesting idea.  Of course they shouldn't be added if they are not
> necessary since deny entries and the problems with the so-called
> "canonical ACL order" are such a bloody mess.
>
>    

Does this mean "deny ACEs must precede non-deny ACEs" or are there more 
requirements?


> OTOH, if you don't fake the mask entry, you need a way to stick the mask
> into the Windows ACL.  Even twice, the normal mask and the default mask.
>
> This only works if you have a SID which you use for this purpose.
>
> Hmm...
>
> What about redefining the NULL SID?  Right now three bits in the
> NULL SID acess mask are used:
>
>    S_ISUID     ->   FILE_APPEND_DATA
>    S_ISGID     ->   FILE_WRITE_DATA
>    S_ISVTX     ->   FILE_READ_DATA
>
> I don't see that anything speaks against adding other meanings to
> the remaining 29 bits.  For instance:
>
>    mask-r      ->   FILE_READ_EA
>    mask-w      ->   FILE_WRITE_EA
>    mask-x      ->   FILE_EXECUTE
>    def-mask-r  ->   FILE_READ_ATTRIBUTES
>    def-mask-w  ->   FILE_WRITE_ATTRIBUTES
>    def-mask-x  ->   FILE_DELETE_CHILD
>
> If we do this, we can add an actual mask and we can not only use it
> in acl(), but also in alloc_sd().
>
> Does that sound useful?
>
>    

Yes.

Some few draft 0.0001 ideas:

setacl: If the mask is set and not 'rwx' then add a NTFS deny ACE for 
each input ACE except 'user::' and 'other:'. The permissions bits of all 
deny ACEs are set equivalent to ~mask. Use current algorithm to build 
remaining NTFS non-deny ACE.

getacl: If the mask is set and not 'rwx' then use the current algorithm 
but ignore all NTFS deny ACEs with permission bits equivalent to ~mask.

chmod: If a mask is set or the current ACL is not minimal then set the 
mask to group permissions and add deny ACEs accordingly. Otherwise set 
the owner group ACE to group permissions.


With this ACL:

user::rwx
group::r-x
user:foo:rwx
group:bar:r-x
mask:rwx
other:r-x

a chmod 0740 would result a NTFS ACL equivalent to:

deny:group::-wx
deny:user:foo:-wx
deny:group:bar:-wx
user::rwx
group::r-x # effective:r--
user:foo:rwx # effective:r--
group:bar:r-x # effective:r--
mask:r--
other:---

Christian
