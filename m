Return-Path: <cygwin-patches-return-8212-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 77733 invoked by alias); 22 Jun 2015 17:15:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 77723 invoked by uid 89); 22 Jun 2015 17:15:48 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.6 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.2
X-HELO: out5-smtp.messagingengine.com
Received: from out5-smtp.messagingengine.com (HELO out5-smtp.messagingengine.com) (66.111.4.29) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Mon, 22 Jun 2015 17:15:47 +0000
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])	by mailout.nyi.internal (Postfix) with ESMTP id 9E6F120FEF	for <cygwin-patches@cygwin.com>; Mon, 22 Jun 2015 13:15:44 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])  by compute1.internal (MEProxy); Mon, 22 Jun 2015 13:15:44 -0400
Received: from [192.168.1.102] (unknown [86.141.128.210])	by mail.messagingengine.com (Postfix) with ESMTPA id 4137CC00288	for <cygwin-patches@cygwin.com>; Mon, 22 Jun 2015 13:15:44 -0400 (EDT)
Subject: Re: [PATCH 1/5] winsup/doc: Create info pages from cygwin documentation
To: cygwin-patches@cygwin.com
References: <1434983976-3612-1-git-send-email-jon.turney@dronecode.org.uk> <1434983976-3612-2-git-send-email-jon.turney@dronecode.org.uk> <20150622145553.GH28301@calimero.vinschen.de>
From: Jon TURNEY <jon.turney@dronecode.org.uk>
Message-ID: <558842B7.3080207@dronecode.org.uk>
Date: Mon, 22 Jun 2015 17:15:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:38.0) Gecko/20100101 Thunderbird/38.0.1
MIME-Version: 1.0
In-Reply-To: <20150622145553.GH28301@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2015-q2/txt/msg00113.txt.bz2

On 22/06/2015 15:55, Corinna Vinschen wrote:
> On Jun 22 15:39, Jon TURNEY wrote:
>> v2:
>> Updated to use docbook2x-texi not docbook2texi, since source is now docbook XML.
>> Tweak DocBook XML so info directory entry has a description.
>>
>> v3:
>> Use a custom charmap to handle &reg;
>>
>> v4:
>> Proper build avoidance
>> texinfo node references may not contain ':', so provide alternate text for a few
>> xref targets
>>
>> 2015-06-22  Jon Turney  <jon.turney@dronecode.org.uk>
>>
>> 	* Makefile.in (install-info, cygwin-ug-net.info)
>> 	(cygwin-api.info): Add.
>> 	* cygwin-ug-net.xml: Add texinfo-node.
>> 	* cygwin-api.xml: Ditto.
>
> This is fine.
>
>> 	* ntsec.xml (db_home): Add texinfo-node for titles containing a
>> 	':' which are the targets of an xref.
>
> This... not so much.  Let's simply remove the colons instead:
>
> -<sect4 id="ntsec-mapping-nsswitch-home"><title id="ntsec-mapping-nsswitch-home.title">The <literal>db_home:</literal> setting</title>
> +<sect4 id="ntsec-mapping-nsswitch-home"><title id="ntsec-mapping-nsswitch-home.title">The <literal>db_home</literal> setting</title>
> [...]

I did consider this, but to be consistent it would needs to be removed 
from all section titles:

> <sect4 id="ntsec-mapping-nsswitch-pwdgrp"><title id="ntsec-mapping-nsswitch-pwdgrp.title">The <literal>passwd:</literal> and <literal>group:</literal> settings</title>
> <sect4 id="ntsec-mapping-nsswitch-enum"><title id="ntsec-mapping-nsswitch-enum.title">The <literal>db_enum:</literal> setting</title>
> <sect4 id="ntsec-mapping-nsswitch-home"><title id="ntsec-mapping-nsswitch-home.title">The <literal>db_home:</literal> setting</title>
> <sect4 id="ntsec-mapping-nsswitch-shell"><title id="ntsec-mapping-nsswitch-shell.title">The <literal>db_shell:</literal> setting</title>
> <sect4 id="ntsec-mapping-nsswitch-gecos"><title id="ntsec-mapping-nsswitch-gecos.title">The <literal>db_gecos:</literal> setting</title>

Even then, it's not consistent with the text, which always treats : as 
part of the keyword.
