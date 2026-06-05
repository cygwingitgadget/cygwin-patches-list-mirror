Return-Path: <SRS0=r81+=EB=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo001.btinternet.com (btprdrgo001.btinternet.com [65.20.50.131])
	by sourceware.org (Postfix) with ESMTP id 48A294BA543C
	for <cygwin-patches@cygwin.com>; Fri,  5 Jun 2026 11:54:04 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 48A294BA543C
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 48A294BA543C
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.131
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1780660444; cv=none;
	b=by9srejrdu29IIMiQfXQ2Sw9Qw9uXfcRbic7CoJ9CE3yPfUt+6vfthDX8FtEjaLANn698HO0c98Vpo1F2mjo3fIwHWRqlvj87Rkl4xvWBkJUa7fIixy8J8Ir3qT7+LV8h7xadzEEc4y+QB2Hr8uPAZ1BcTjayRw2AiprpElK3sw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1780660444; c=relaxed/simple;
	bh=4aNi9JnSGlNsB0YFSjDp9UlSb+eO9shQAT4HjOwUNPY=;
	h=Message-ID:Date:MIME-Version:Subject:From; b=SSARs4es5yXb1QZRC/nbJw+Jldz0NgPQCWEQo9TbV99wnENIHiYWwromPSRjSwUWwg0KD1s6wzfMBYffgXZhLfAkX3s/Sa2ij92g7qzKJkXZ3ABsHzcwxDv5/S8UhRPAboA3kr0Zytj0pkL+czwbneuVfwjTmr+2o/eaB71c5iw=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 48A294BA543C
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 69E784C503B4083A
X-Originating-IP: [83.105.142.8]
X-OWM-Source-IP: 83.105.142.8
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=30/300, class=clean
X-RazorGate-Vade: dmFkZTESsBPoSEpWGDgu8OHUr/7N+B+Y0WbmVGJu0IPEF/z2XzyuQ1pU14/GufRlITq5RCP9z9vVg/mVktBJHpAeuwV4P9leLUD8e9Xpb7F/a8BFCK5XgLg2YvuwwEy9SncnpfdbHzeXKhomkgaqULzgs89xcjiDpIOeVZaOQJzehCRbxydZ5xKVi7xygr2lohRsiT0oi9KQNLYbmtpWUsJ1G3O/wG+JySZoTbeBa/Hhfu1FNjii1ZgpJ1X/ruBB+vi7Ry570LqZCgfrMGu15p9HMhmDwdO92gYWl0ynuMmVMdWXzS5LAEhLF+bUd8Zbt6aAzffJ1MZjCwJLvbutktldoni1MXXd199Jnx1Lxg2PF+DgVTRHxIpV+2BQdjzDyqMIfOBOTzi3NsnrTvd+tJoIC/tIqIzmYfMd188X9HbxsZTaEaskKx47IocUS2jsTVHg2nd2CMUqzWPZyl6msxi8LvyOEQZbRaSUoc7LVR6BIvKbHcmwYrFcOA/PvbJVJV0P+ltAHefLmMcTDdIWQ9Xl1UI8Jh5Bzdx2ExR6wmJ8eVnYsJdfV1xT00dklZvRht6CMQN9zQzvecI/Xfe25e625e0ObBjuTMfNTTq45Enq1SmA3UGjZMXAGUML3cQ5MWkeehO8FuWzirB2ODAofGsAuejOvVGGnWla8ZWCwqe0e0OspQ
X-RazorGate-Vade-Verdict: clean 30
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.109] (83.105.142.8) by btprdrgo001.btinternet.com (authenticated as jonturney@btinternet.com)
        id 69E784C503B4083A for cygwin-patches@cygwin.com; Fri, 5 Jun 2026 12:54:01 +0100
Message-ID: <93eadabc-c445-4745-a7bf-2ae44e107b74@dronecode.org.uk>
Date: Fri, 5 Jun 2026 12:54:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: Only compute BFD_LIBS if building dumper
References: <20260529130140.1275824-1-jon.turney@dronecode.org.uk>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-GB
Cc: cygwin-patches@cygwin.com
In-Reply-To: <20260529130140.1275824-1-jon.turney@dronecode.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,MISSING_HEADERS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 29/05/2026 14:01, Jon Turney wrote:
> Don't bother trying to determine the flags needed to link the BFD
> library if we're not even building dumper.
> 
> (AC_NO_EXECUTABLES doesn't do what the name would simply suggest: It
> silently checks if a trivial program can link, and turns itself off if
> that suceeds.
> 
> Tests which rely on linking are only made to fail by AC_NO_EXECUTABLES
> if that trivial link has failed (which OK, were probably going to fail
> anyway, but now you get the error 'link tests are not allowed after
> AC_NO_EXECUTABLES', which is perhaps slightly more informative when you
> are cross-compiling with a bootstrap compiler).)
> 
> Anyhow, if we're using a compiler which can't link executables, these
> instances of AC_CHECK_LIB will definitely fail.  But we can't possibly
> build dumper in that situation, so we'll be configuring with
> --disable-dumper, and doing those checks serves no purpose.
Pushed.
