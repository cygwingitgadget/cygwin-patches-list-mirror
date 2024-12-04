Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id CA6E13858CDB; Wed,  4 Dec 2024 12:54:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org CA6E13858CDB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1733316893;
	bh=q3OWRMtEppp4MnV23bnOBdceRjIKB0NeWs6QnzMRsvo=;
	h=From:To:Subject:Date:Reply-To:From;
	b=jPBYnYZtKGq86Np4Xo3jgr+lU9SGuBkjjgCglE8yXGzAuuZHBrSdHJF82M4ECYeNM
	 xvvaTbxu/Z75+FsM6KH8CRjjkc4IuzvfxrMewNkKwEOEl11kzd5ChdkJdWiXGhcF7N
	 WGXdEUzMgc+Kak1hsPdt4AInhd+J3GopAt4eKs+w=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id C9BAAA80659; Wed,  4 Dec 2024 13:54:47 +0100 (CET)
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: setjmp/longjmp: decrement incyg after signal handling
Date: Wed,  4 Dec 2024 13:54:47 +0100
Message-ID: <20241204125447.316279-1-corinna-cygwin@cygwin.com>
X-Mailer: git-send-email 2.47.0
Reply-To: cygwin-patches@cygwin.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cygwin-patches.cygwin.com>

From: Corinna Vinschen <corinna@vinschen.de>

Commit 0b6fbd396ca2f ("* exceptions.cc (_cygtls::interrupt_now): Revert
to checking for "spinning" when choosing to defer signal.") introduced
a bug in the loop inside the stabilize_sig_stack subroutine:

First, stabilize_sig_stack grabs the stacklock. The _cygtls::incyg
flag is then incremented before checking if a signal has to be handled
for the current thread.

If no signal waits, the code simply jumps out, decrements _cygtls::incyg
and returns to the caller, which eventually releases the stacklock.

However, if a signal is waiting, stabilize_sig_stack releases the
stacklock, calls _cygtls::call_signal_handler(), and returns to
the start of the subroutine, trying to grab the lock.

After grabbing the lock, it increments _cygtls::incyg... wait...
again?

The loop does not decrement _cygtls::incyg after
_cygtls::call_signal_handler(), which returns with _cygtls::incyg
set to 1.  So it increments incyg to 2.  If no other signal is
waiting, stabilize_sig_stack jumps out and decrements _cygtls::incyg
to 1.  Eventually, setjmp or longjmp both will return to user
code with _cygtls::incyg set to 1.  This *may* be fixed at some later
point when signals arrive, but there will be a time when the application
runs in user code with broken signal handling.

Fixes: 0b6fbd396ca2f ("* exceptions.cc (_cygtls::interrupt_now): Revert to checking for "spinning" when choosing to defer signal.")
Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
---
 winsup/cygwin/scripts/gendef | 1 +
 1 file changed, 1 insertion(+)

diff --git a/winsup/cygwin/scripts/gendef b/winsup/cygwin/scripts/gendef
index 7e14f69cf71c..377ceb59b2c8 100755
--- a/winsup/cygwin/scripts/gendef
+++ b/winsup/cygwin/scripts/gendef
@@ -344,6 +344,7 @@ stabilize_sig_stack:
 	movq	\$_cygtls.start_offset,%rcx	# point to beginning
 	addq	%r12,%rcx			#  of tls block
 	call	_ZN7_cygtls19call_signal_handlerEv
+	decl	_cygtls.incyg(%r12)
 	jmp	1b
 3:	decl	_cygtls.incyg(%r12)
 	addq	\$0x20,%rsp
-- 
2.47.0

