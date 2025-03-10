Return-Path: <SRS0=ViIi=V5=chrisdenton.dev=chris@sourceware.org>
Received: from sender2-op-o19.zoho.eu (sender2-op-o19.zoho.eu [136.143.171.19])
	by sourceware.org (Postfix) with ESMTPS id D2A033858D21
	for <cygwin-patches@cygwin.com>; Mon, 10 Mar 2025 21:08:18 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D2A033858D21
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=chrisdenton.dev
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=chrisdenton.dev
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D2A033858D21
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=136.143.171.19
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1741640899; cv=pass;
	b=g2yBH/pI1YAVXwE9gD01IUn/gf9LYXhCaCRi67IBPrwsV4Osotb+xTc85JL4hhadkYglb0AISNARkJsRoChixMSQlfJSUiWYyI64wi8hGRGDeuZ/hYG5TZJk4P62BuvR8uS1N+zWUE340JOucaT9VvSep1eAlF+ax1r0op2EA6E=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1741640899; c=relaxed/simple;
	bh=Z4T07ms3rGZ5HLTmf/5cYJ5i6shmwNf7fCObmCP9t1A=;
	h=DKIM-Signature:Date:From:To:Message-ID:Subject:MIME-Version; b=wxPmIXFrAEhDoyn8Rh/GAQqRMZgp+trODnBz8a3yYKxfa9lhTRWw7k4cErcn1Vgr6RktB6EkJBqAPuc540vapiF9/8rg3iDMK4iRYIcHHlHRcmOzlkCos5QWx+BrC02Ze6OsT+gXSkW7z5+8lR1htyupUudZo8s0OFzzAwD0H5I=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D2A033858D21
ARC-Seal: i=1; a=rsa-sha256; t=1741640894; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=KKuc28xGBD5w4Kj+PIhE6mpvd/CNPCB0gEf/ChbtwnNUBHlqPBNjMWAOEeDY0uyDITUb+5nQZ9soBhmcfRV9Gwz30F4BA/7uc/zoE0SWkn5tDlb0XIF4P2IX2ziUAVClihk8qzEDc8qynTLEmXKPbeuo8L8T29EUfs+B/PNucAo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1741640894; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=X2iiSZ8ivk+4xkv8YWsAI4bosViYo3hLfNaHoxQYs+c=; 
	b=ZOkd33J4H/nDTsrfvP9KN6wa/BzHoTBDtu6p1E9s9qzRxJGiLB1jglgp7e3jQSpIiaiOLOR0+lsUKfGK5o8Gvx7LWT87R4pvpaZd8dfKyTspfBz6dbTTW7Z4GoUzlRapKG+li7Jq2tT4IR4joOAt5QYKunAnLliw9OSWSUzy59M=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=chrisdenton.dev;
	spf=pass  smtp.mailfrom=chris@chrisdenton.dev;
	dmarc=pass header.from=<chris@chrisdenton.dev>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1741640894;
	s=zmail; d=chrisdenton.dev; i=chris@chrisdenton.dev;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=X2iiSZ8ivk+4xkv8YWsAI4bosViYo3hLfNaHoxQYs+c=;
	b=fDYt6kguw1NJec422nLxz7DjyXzjXU+l6qffhYl30ZQOIDHyWqa72KbMxMdothyu
	2Pf7isKhm+Rlm7NBa7O9oYxZu1GpcJ+IetryhpEMTlEknAFiQziuVgPOAAjkMhRei43
	zzKFQuZUoZHz4LGvxuXttYFtTX6G7UpcAovh6/ps=
Received: from mail.zoho.eu by mx.zoho.eu
	with SMTP id 1741640893887451.62190000054875; Mon, 10 Mar 2025 22:08:13 +0100 (CET)
Date: Mon, 10 Mar 2025 21:08:13 +0000
From: Chris Denton <chris@chrisdenton.dev>
To: "cygwin-patches" <cygwin-patches@cygwin.com>
Cc: "squallatf" <squallatf@gmail.com>
Message-ID: <19581e3058e.ebf97e1e733524.5029218649132507579@chrisdenton.dev>
In-Reply-To: <Z886PJK2OMtcUwEC@calimero.vinschen.de>
References: <19580bc11ec.e77085b5699413.240072222093655736@chrisdenton.dev> <Z886PJK2OMtcUwEC@calimero.vinschen.de>
Subject: Re: [PATCH] fix native symlink spawn passing wrong arg0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_INVALID,DKIM_SIGNED,GIT_PATCH_0,KAM_DMARC_STATUS,KAM_STOCKGEN,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Currently when starting a process from bash via a native symlink, argv[0] is
set to the realpath of the executable and not to the link name. This patch fixes
it so the path of the symlink is seen instead.

The cause is a path conversion in perhaps_suffix which follows native
symlinks. Hence the fix this patch uses is to add PC_SYM_NOFOLLOW_REP when
calling path_conv::check to prevent that.

Fixes: 1fd5e000ace55 ("import winsup-2000-02-17 snapshot")
Signed-off-by: SquallATF <squallatf@gmail.com>
---
 winsup/cygwin/spawn.cc | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index 06b84236d..ef175e708 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -43,7 +43,9 @@ perhaps_suffix (const char *prog, path_conv& buf, int& err, unsigned opt)
 
   err = 0;
   debug_printf ("prog '%s'", prog);
-  buf.check (prog, PC_SYM_FOLLOW | PC_NULLEMPTY | PC_POSIX, stat_suffixes);
+  buf.check (prog,
+	     PC_SYM_FOLLOW | PC_SYM_NOFOLLOW_REP | PC_NULLEMPTY | PC_POSIX,
+	     stat_suffixes);
 
   if (buf.isdir ())
     {
-- 
2.48.1.windows.1



---- On Mon, 10 Mar 2025 19:15:08 +0000 Corinna Vinschen  wrote ---

 > Hi Chris, 
 >  
 > On Mar 10 15:46, Chris Denton wrote: 
 > > This upstreams the msys2 patch: 
 > > https://github.com/msys2/MSYS2-packages/blob/6a02000fd93c6b2001220507e5369a726b6381c4/msys2-runtime/0021-Fix-native-symbolic-link-spawn-passing-wrong-arg0.patch 
 > > 
 > > Original msys2 issue: 
 > > https://github.com/msys2/MSYS2-packages/issues/1327 
 >  
 > Sorry, but not like this. The commit message should describe the problem 
 > and the chosen solution, not just point to some external websites. 
 >  
 > It's also missing a Fixes: and a Signed-off-by: line, the latter ideally 
 > from the original author of the patch. 
 >  
 > > --- 
 > >  winsup/cygwin/spawn.cc | 2 +- 
 > >  1 file changed, 1 insertion(+), 1 deletion(-) 
 > > 
 > > diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc 
 > > index 06b84236d..b81ccefb7 100644 
 > > --- a/winsup/cygwin/spawn.cc 
 > > +++ b/winsup/cygwin/spawn.cc 
 > > @@ -43,7 +43,7 @@ perhaps_suffix (const char *prog, path_conv& buf, int& err, unsigned opt) 
 > > 
 > >    err = 0; 
 > >    debug_printf ("prog '%s'", prog); 
 > > -  buf.check (prog, PC_SYM_FOLLOW | PC_NULLEMPTY | PC_POSIX, stat_suffixes); 
 > > +  buf.check (prog, PC_SYM_FOLLOW | PC_SYM_NOFOLLOW_REP | PC_NULLEMPTY | PC_POSIX, stat_suffixes); 
 >  
 > Formatting should try to stick to max. 80 chars per line, please. 
 >  
 >  
 > Thanks, 
 > Corinna 
 > 

