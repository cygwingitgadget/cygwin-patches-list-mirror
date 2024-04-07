Return-Path: <SRS0=gSW7=LM=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	by sourceware.org (Postfix) with ESMTPS id 006943858D20
	for <cygwin-patches@cygwin.com>; Sun,  7 Apr 2024 19:34:58 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 006943858D20
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 006943858D20
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.16
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1712518500; cv=none;
	b=XITto7nCvWE6UX/6XY0RZD7QJIwc9eLCq1Wut9o5zlPn1vLlqk3WPoKtRVQi5qFkr9DnUf13DXcM9zX5hq8kISks3XQdH2NuoYJrDbZo9B0VP4FRUMq9nAwBjGzIyJAkVg0+SG8o8N41sSaxmRq1+ao82KIhX2zSoWVr3j7RCHA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1712518500; c=relaxed/simple;
	bh=M1syKPV1xA/g4iDvPcgBCsrrrQQtdCNns5I0Bspsr5c=;
	h=Message-ID:Date:MIME-Version:To:From:Subject; b=qvfMCFcGGiiYL7niKJX/5vInR6EHmsELJikLsQRZ4Js5Bn3kxfxKEoGMbMawq3tObxrxfVcFeO+6OJYZmB54wJJOdhePm7WjPSblDd806+hDEsNpG1CaF9d48+QOw97Wn8noAz+Z70frQUl4Qct8I4mc4nCJ3UYQgcl8yvimdJY=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 958851C0235
	for <cygwin-patches@cygwin.com>; Sun,  7 Apr 2024 19:34:57 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf15.hostedemail.com (Postfix) with ESMTPA id 3298718
	for <cygwin-patches@cygwin.com>; Sun,  7 Apr 2024 19:34:56 +0000 (UTC)
Message-ID: <0df79ac3-02ea-4180-8177-375407dee2a1@SystematicSW.ab.ca>
Date: Sun, 7 Apr 2024 13:34:55 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: cygwin-patches@cygwin.com
Content-Language: en-CA
To: Cygwin Patches <cygwin-patches@cygwin.com>
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Subject: /proc/<pid>/{cwd,root} links to <defunct> for cygrunsrv, daemons, and
 shells
Organization: Systematic Software
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 3298718
X-Stat-Signature: ego5xubyg3tzyihqna1skk6rn5aq5e3t
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX18ol/GLgqJEz7634dy6PRPvy7jVQMUIzX0=
X-HE-Tag: 1712518496-918761
X-HE-Meta: U2FsdGVkX1/j3iQ2zOxozudvTt+Ljq23BZPAfUpj4nRnh0GwPpg3aW8cFIaH5+/zuTIOnL2YJ1Db0AMso/TYR68lELpvRVO8waAaPy65nkhuz38dWOWcuTG1Zt6Vu08SpPrJfGEaGIxeRK9/yBrT9NGLpAKVjmQQlyWy2kLJhJv8Uns/sDYumjQH1OSJuRyoQgniGSuqBOc/LtkKs3N02Hd3tjOmT3EcM4SLVF2AB77EJmrgjCu4TOsfKN22i31uiYEG8NChCSgf2FBO/Jn8WEGGhix9g6Rbx/RkD2B9rtek9znwh4SeVljvacRKjLzDtmn72qTe46LBB8G9JUqtzrjShgDDtqi5
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

ISTM anomalous that for cygrunsrv, daemons, cron processes, and shells 
/proc/<pid>/{cwd,root} have bad symlinks to "<defunct>", normally a process or 
exe status:

/proc/732/exe   -> /usr/bin/cygrunsrv
/proc/732/root  -> <defunct>
/proc/732/cwd   -> <defunct>
|  /proc/733/exe   -> /usr/sbin/cygserver
  ->/proc/733/root  -> <defunct>
    /proc/733/cwd   -> <defunct>
/proc/740/exe   -> /usr/bin/cygrunsrv
/proc/740/root  -> <defunct>
/proc/740/cwd   -> <defunct>
|  /proc/741/exe   -> /usr/sbin/syslog-ng
  ->/proc/741/root  -> <defunct>
    /proc/741/cwd   -> <defunct>
/proc/748/exe   -> /usr/bin/cygrunsrv
/proc/748/root  -> <defunct>
/proc/748/cwd   -> <defunct>
|  /proc/749/exe   -> /usr/sbin/cron
  ->/proc/749/root  -> <defunct>
    /proc/749/cwd   -> <defunct>
    |  /proc/2080/exe  -> /usr/sbin/cron
     ->/proc/2080/root -> <defunct>
       /proc/2080/cwd  -> <defunct>
       |  /proc/2082/exe  -> /usr/bin/bash
        ->/proc/2082/root -> <defunct>
          /proc/2082/cwd  -> <defunct>

Should we consider changing that to root "/", or nothing, null, or something 
meaningful?

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retirer     but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
