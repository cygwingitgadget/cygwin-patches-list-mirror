Return-Path: <SRS0=p9wN=Y3=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	by sourceware.org (Postfix) with ESMTPS id 2C17C3821B66
	for <cygwin-patches@cygwin.com>; Thu, 12 Jun 2025 21:54:40 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 2C17C3821B66
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 2C17C3821B66
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.13
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1749765280; cv=none;
	b=bxkEd/ukeV6EP1ecGqoW++XNggZv10oO9MsYin8DNiHyySSfg9BmozWsM7C/gqDhCi00QmutHr3qQJvRnudeEdhM0enipMkTA3ejIbruEigBgr5pItRFwKCb50JtPH7fg8TZ9lEJBcFBSco3iZlT5iS1UqHpK1MPXM8QvzMdQpk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1749765280; c=relaxed/simple;
	bh=cduRVI6JI5peUDySmNdlTBqTTDIg9dZAD//7CA/yL80=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:DKIM-Signature; b=OVh8JnZsGLXgXkRYeOgICdRkVppaSleYoIC7M5u11jOPP0VStT5lenOJyT97My8hqtCL9lpbF8adpmj/yDYvzILk3Gv6e3Nc6qQsjDGE2PC/rznu/CsB0Y2e0sbtH6ygEq3q1XcvouzU3d6jUf6POd0HCJqVUOR+TKTNcu7YV/8=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2C17C3821B66
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=oT10BlK6
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id CCB3C100678
	for <cygwin-patches@cygwin.com>; Thu, 12 Jun 2025 21:54:39 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf02.hostedemail.com (Postfix) with ESMTPA id 6002D80011
	for <cygwin-patches@cygwin.com>; Thu, 12 Jun 2025 21:54:38 +0000 (UTC)
Message-ID: <7329e318-02fc-40d0-8f06-7c5ef8642182@SystematicSW.ab.ca>
Date: Thu, 12 Jun 2025 15:54:37 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: implement spinlock pause for AArch64
Content-Language: en-CA
To: cygwin-patches@cygwin.com
References: <DB9PR83MB09237758F38BC0ACB9AAB51B9274A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <c03e5943-d622-4381-8ce1-c85f1ffa3c69@SystematicSW.ab.ca>
 <e768114d-c2e5-7033-c30d-9991c5982f3b@jdrake.com>
Organization: Systematic Software
In-Reply-To: <e768114d-c2e5-7033-c30d-9991c5982f3b@jdrake.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 6002D80011
X-Stat-Signature: twwgro6cmuzfxhfi13hi1szywft8d3rs
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX1/DwTwhyH+22SL8WjKiYqVZIZWg9hu1RF0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=message-id:date:mime-version:from:reply-to:subject:to:references:in-reply-to:content-type:content-transfer-encoding; s=he; bh=//dwKhYNKlYr+mInfq0JEhozyR+BVNUgNkMpJ0YjVvc=; b=oT10BlK6KoTHVKwZVGXcAOyQDsqyM3C1++n0rGNrPI8ESpBPhPac5mh/As1LtEtf/oFHyJKjLaih2BQOH1jpGrrUCG9x6RTSkfccVJ3seRxvCucoWCPuzXHf6nOmjajtRByPvfsmN+chpXPgBW0klhGszdZwCT+vCwhiOGYWuHb7TNvGf/yH6lcZuWIcvCUiUTetePygsi0nknSlrxiVKuSukP7OkBPgusRgVh+YFX0XahVNbqOoWd7RoCW27XjIBxk4jf+P88QAqWhYXIIKhv+Fzpfw9thqvCYHvQPvzpZsN6hzWFWGLH+pWza+b3JxObIwG1DW/aBTi2QQYJWxxg==
X-HE-Tag: 1749765278-585248
X-HE-Meta: U2FsdGVkX1/gwATEXAWybY45WmPWMnCVbk61wxwgGA4zEz1u/ijRg0bUabWlN6OQYvQxBhNjtwXuXGhjeMP6EF+NObyx9f7LJv+scahcQbBEdIHTatAaelJvGWdIwYPP1uzpyAR0nOztT0ijwER9bjeAbzwNkJQEYYRnvGwCk9KRt6ZgsnrNIrafA6B9n2QGCuvGFWuO7QEpv2+ZlwMpdL1SunSJD7tg1MofIyo9TkkXRqYztYPEP+Xzp1oO22qTFsP22o5nGXFnexTK0nkWKYY5TYjRchkMowvKEXcok4JbduBSTNMBTc5icQ2LzavThp/ayHYXuZGhlV1Q+jJgz8+6el4xGzXXczIGPAeDg7Yq6JuzyI2fZKOjPF0PnLqZNQnt6TZ+tTU=
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2025-06-12 14:47, Jeremy Drake via Cygwin-patches wrote:
> On Thu, 12 Jun 2025, Brian Inglis wrote:
>> Rust apparently uses yield on arm32, and isb (instruction sync barrier) on
>> aarch64, as yield is effectively a NOP (although it could be implemented to
>> free up pipeline slots, SMT switch, or signal), while isb (with optional sy
>> operand) is more like pause on x86_64:
> 
> I looked up what mingw-w64 does, and for both arm32 and aarch64 they use
> "dmb ishst" followed by "yield" for YieldProcessor().  I think this makes
> sense, since you'd want any pending stores to be available before
> re-checking the spin condition.

That may be better depending on load and store acquire/release options described
in relation to barriers:

	https://github.com/eclipse-openj9/openj9/issues/6332

	https://devblogs.microsoft.com/oldnewthing/20220812-00/?p=106968

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retrancher  but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
