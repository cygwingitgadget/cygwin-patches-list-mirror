Return-Path: <cygwin-patches-return-8217-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 65707 invoked by alias); 23 Jun 2015 11:27:38 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 65686 invoked by uid 89); 23 Jun 2015 11:27:36 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.7 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.2
X-HELO: out5-smtp.messagingengine.com
Received: from out5-smtp.messagingengine.com (HELO out5-smtp.messagingengine.com) (66.111.4.29) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Tue, 23 Jun 2015 11:27:35 +0000
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])	by mailout.nyi.internal (Postfix) with ESMTP id 7E315204C7	for <cygwin-patches@cygwin.com>; Tue, 23 Jun 2015 07:27:33 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])  by compute2.internal (MEProxy); Tue, 23 Jun 2015 07:27:33 -0400
Received: from [192.168.1.102] (unknown [86.141.128.210])	by mail.messagingengine.com (Postfix) with ESMTPA id A99766800AD	for <cygwin-patches@cygwin.com>; Tue, 23 Jun 2015 07:27:32 -0400 (EDT)
Subject: Re: [PATCH 1/5] winsup/doc: Create info pages from cygwin documentation
To: cygwin-patches@cygwin.com
References: <1434983976-3612-1-git-send-email-jon.turney@dronecode.org.uk> <1434983976-3612-2-git-send-email-jon.turney@dronecode.org.uk> <20150622145553.GH28301@calimero.vinschen.de> <558842B7.3080207@dronecode.org.uk> <20150622184036.GN28301@calimero.vinschen.de>
From: Jon TURNEY <jon.turney@dronecode.org.uk>
Message-ID: <5589429B.1010100@dronecode.org.uk>
Date: Tue, 23 Jun 2015 11:27:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:38.0) Gecko/20100101 Thunderbird/38.0.1
MIME-Version: 1.0
In-Reply-To: <20150622184036.GN28301@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2015-q2/txt/msg00118.txt.bz2

On 22/06/2015 19:40, Corinna Vinschen wrote:
> On Jun 22 18:15, Jon TURNEY wrote:
>> On 22/06/2015 15:55, Corinna Vinschen wrote:
>>> On Jun 22 15:39, Jon TURNEY wrote:
>>>> v2:
>>>> Updated to use docbook2x-texi not docbook2texi, since source is now docbook XML.
>>>> Tweak DocBook XML so info directory entry has a description.
>>>>
>>>> v3:
>>>> Use a custom charmap to handle &reg;
>>>>
>>>> v4:
>>>> Proper build avoidance
>>>> texinfo node references may not contain ':', so provide alternate text for a few
>>>> xref targets
>>>>
>>>> 2015-06-22  Jon Turney  <jon.turney@dronecode.org.uk>
>>>>
>>>> 	* Makefile.in (install-info, cygwin-ug-net.info)
>>>> 	(cygwin-api.info): Add.
>>>> 	* cygwin-ug-net.xml: Add texinfo-node.
>>>> 	* cygwin-api.xml: Ditto.
>>>
>>> This is fine.
>>>
>>>> 	* ntsec.xml (db_home): Add texinfo-node for titles containing a
>>>> 	':' which are the targets of an xref.
>>>
>>> This... not so much.  Let's simply remove the colons instead:
>>>
>>> -<sect4 id="ntsec-mapping-nsswitch-home"><title id="ntsec-mapping-nsswitch-home.title">The <literal>db_home:</literal> setting</title>
>>> +<sect4 id="ntsec-mapping-nsswitch-home"><title id="ntsec-mapping-nsswitch-home.title">The <literal>db_home</literal> setting</title>
>>> [...]
>>
>> I did consider this, but to be consistent it would needs to be removed from
>> all section titles:
>>
>>> <sect4 id="ntsec-mapping-nsswitch-pwdgrp"><title id="ntsec-mapping-nsswitch-pwdgrp.title">The <literal>passwd:</literal> and <literal>group:</literal> settings</title>
>>> <sect4 id="ntsec-mapping-nsswitch-enum"><title id="ntsec-mapping-nsswitch-enum.title">The <literal>db_enum:</literal> setting</title>
>>> <sect4 id="ntsec-mapping-nsswitch-home"><title id="ntsec-mapping-nsswitch-home.title">The <literal>db_home:</literal> setting</title>
>>> <sect4 id="ntsec-mapping-nsswitch-shell"><title id="ntsec-mapping-nsswitch-shell.title">The <literal>db_shell:</literal> setting</title>
>>> <sect4 id="ntsec-mapping-nsswitch-gecos"><title id="ntsec-mapping-nsswitch-gecos.title">The <literal>db_gecos:</literal> setting</title>
>
> I missed something, apparently.  From where are these three referenced,
> but not the others?

> $ egrep -H 'xref linkend="ntsec-mapping-nsswitch-(home|shell|gecos|enum|pwdgrp)' ntsec.xml
> ntsec.xml:       See <xref linkend="ntsec-mapping-nsswitch-home"></xref>.</seg>
> ntsec.xml:       See <xref linkend="ntsec-mapping-nsswitch-shell"></xref>.</seg>
> ntsec.xml:       See <xref linkend="ntsec-mapping-nsswitch-gecos"></xref>.</seg>
> ntsec.xml:       See <xref linkend="ntsec-mapping-nsswitch-home"></xref>.</seg>
> ntsec.xml:       See <xref linkend="ntsec-mapping-nsswitch-shell"></xref>.</seg>
> ntsec.xml:       See <xref linkend="ntsec-mapping-nsswitch-gecos"></xref>.</seg>

It's seems to be a peculiarity of the .info format that a title with a 
':' in it is fine, but you can't make an xref to it without providing an 
alternate link text, as ':' terminates the link text

>> Even then, it's not consistent with the text, which always treats : as part
>> of the keyword.
>
> Yeah.  I'm not overly happy with this myself.  I didn't know how better
> I could make clear that the colon is part of the keyword.
>
> So, ok.  Please apply.  Maybe it makes sense to add texinfo-nodes for
> the others in the list above as well?  Just in case?

I think there are other titles elsewhere, which are also not the target 
of a xref.

A "warning: @ref cross-reference name should not contain `:'" is emitted 
where this problem exists.


