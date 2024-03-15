Return-Path: <SRS0=Hkds=KV=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	by sourceware.org (Postfix) with ESMTPS id 09C433858C41
	for <cygwin-patches@cygwin.com>; Fri, 15 Mar 2024 16:51:47 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 09C433858C41
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 09C433858C41
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.11
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1710521509; cv=none;
	b=qHT6EV4Gn41D4Z1L7kd5VV65/qFmq3sewGW5CwYVJyeiTG1ZLiJFxhUrB8UKm22xqdg8vjDfepVdtPDhWNn28mo9DuqVS+sOGCm/owpKjpa/IKKpWONyRalyJymxz9YbybMeP23LUkD6oTUDXcFbAKsRrTyMn4ucblgZ8ybHBcQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1710521509; c=relaxed/simple;
	bh=Tr7bEBvgcg0NqjU9Qmps/ANStv7T1xBX14rvmo4tpOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=ZUPZDOWKAiXz5oNJc1US7qw9XQySO1WlafurpTa+9397HL27vQ6e/8BtFLVDIuKN0SS8/8eo7dxRSXPY770V+vErY/ERfvWp6/mW897x83pVlWqNF2H6x9H3zYRI0VVcjyn4iKFkG5dwf6hkf3sq8ulAA8SajZykJBe3EzLE72s=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 8B69AA17DE
	for <cygwin-patches@cygwin.com>; Fri, 15 Mar 2024 16:51:46 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf17.hostedemail.com (Postfix) with ESMTPA id 26B8818
	for <cygwin-patches@cygwin.com>; Fri, 15 Mar 2024 16:51:44 +0000 (UTC)
Message-ID: <ea5d3c7a-2c8d-4ba9-9220-d90a22c9b539@SystematicSW.ab.ca>
Date: Fri, 15 Mar 2024 10:51:43 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: cygwin-patches@cygwin.com
Subject: Re: newlib-cygwin build fails on dumper
Content-Language: en-CA
To: cygwin-patches@cygwin.com
References: <9599b8e1-6d67-4b00-b7af-c412298d78af@SystematicSW.ab.ca>
 <ZfQQld7O6NImhJBP@calimero.vinschen.de>
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Organization: Systematic Software
In-Reply-To: <ZfQQld7O6NImhJBP@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 26B8818
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Rspamd-Server: rspamout02
X-Stat-Signature: 4qkz5ii3s8dgj8tdi6ah4uc4m3xgxem6
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX1/0+x+0KCi0Z13B8pF4VLycVtlnyzUXkmA=
X-HE-Tag: 1710521504-793320
X-HE-Meta: U2FsdGVkX1/xe13p1+0KnVqkb4jMkBLLWiS7ErdDukZwYCiyC6TnDAV+HojUJ4Id0nCoQnNaTfwFcDfYciYllQArgxaUZhcgM8RImieSRNicITzsDRCDkbQG60Ehq3RG7DDj/1550rUkhRoLev6WBIJqMb1w0EAmMfGbnT0L9KdDfndYWpy7/641IF5onHuFIlaflfu8R1dggRSW3MIpAhawJD8UsRUwFJXOFTTaM6BXcAHYmYQKON0CenrhpRqFXf8vx1smQS8Kt+tuPR2w7hOex9oH4EA6Vr8QRfSbADkNzqwmo6G40gywTbnLnExtckZsPNndayVZD4ZGVu6c8p8e6iBP8zf7
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2024-03-15 03:10, Corinna Vinschen wrote:
> On Mar 14 10:10, Brian Inglis wrote:
>> During newlib-cygwin build to test patches, with latest current stable
>> packages as of last weekend, and yesterday's repo main/master, get a
>> warning, then errors building dumper:

> I'm pretty sure this isn't the latest newlib-cygwin main.
> 
> The getentropy warning has been fixed on 2023-09-25 by commit
> a9e8e3d1cb82 ("newlib: Add missing prototype for _getentropy")
> 
> The ATTRIBUTE_WARN_UNUSED_RESULT error message has been fixed on
> 2024-02-12 by commit 10c8c1cf4f94 ("include/ansidecl.h: import from
> binutils-gdb")

Thanks Corinna,

I think I missed the -b after checkout, changed to an old existing local branch 
rather than creating one, and did not notice the discrepancy, so I should 
version the branches appropriately to avoid repeating this kind of thing! ;^>

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retirer     but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
