Return-Path: <cygwin-patches-return-6530-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31200 invoked by alias); 3 Jun 2009 23:13:53 -0000
Received: (qmail 31190 invoked by uid 22791); 3 Jun 2009 23:13:52 -0000
X-SWARE-Spam-Status: No, hits=-2.1 required=5.0 	tests=AWL,BAYES_00,J_CHICKENPOX_74,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail-bw0-f226.google.com (HELO mail-bw0-f226.google.com) (209.85.218.226)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 03 Jun 2009 23:13:22 +0000
Received: by bwz26 with SMTP id 26so381549bwz.2         for <cygwin-patches@cygwin.com>; Wed, 03 Jun 2009 16:13:18 -0700 (PDT)
Received: by 10.204.114.136 with SMTP id e8mr1365048bkq.190.1244070798855;         Wed, 03 Jun 2009 16:13:18 -0700 (PDT)
Received: from ?192.168.2.99? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id 1sm3031292fks.41.2009.06.03.16.13.17         (version=SSLv3 cipher=RC4-MD5);         Wed, 03 Jun 2009 16:13:18 -0700 (PDT)
Message-ID: <4A270656.8090704@gmail.com>
Date: Wed, 03 Jun 2009 23:13:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [PATCH?]  Separate pthread patches, #2 take 2.
Content-Type: multipart/mixed;  boundary="------------030707010101040107020500"
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
X-SW-Source: 2009-q2/txt/msg00072.txt.bz2

This is a multi-part message in MIME format.
--------------030707010101040107020500
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 1453


  The attached patch implements ilockexch and ilockcmpexch, using the inline
asm definition from __arch_compare_and_exchange_val_32_acq in
glibc-2.10.1/sysdeps/i386/i486/bits/atomic.h, trivially expanded inline rather
than in its original preprocessor macro form.

  It generates incorrect code.  The sequence discussed before,

126	  do
127	    node->next = head;
128	  while (InterlockedCompareExchangePointer (&head, node, node->next) !=
node->next);

is now compiled down to this loop:

L186:
	.loc 3 127 0
	movl	__ZN13pthread_mutex7mutexesE+8, %edx	 # mutexes.head, D.28599
	.loc 2 58 0
	movl	%edx, %eax	 # D.28599, tmp68
/APP
 # 58 "/gnu/winsup/src/winsup/cygwin/winbase.h" 1
	lock cmpxchgl %ebx, __ZN13pthread_mutex7mutexesE+8	 # this,
 # 0 "" 2
/NO_APP
	movl	%eax, -12(%ebp)	 # tmp68, ret
	.loc 2 59 0
	movl	-12(%ebp), %eax	 # ret, D.28596
	.loc 3 126 0
	cmpl	%eax, %edx	 # D.28596, D.28599
	jne	L186	 #,
	movl	%edx, 36(%ebx)	 # D.28599, <variable>.next


... which is in fact the equivalent of

126	  do
127	    ;
128	  while (InterlockedCompareExchangePointer (&head, node, node->next) !=
node->next);
(126)     node->next = head;

  As it caches the values of head in %edx during the spin loop, and only
stores it to node->next after having overwritten *head with node, there is a
short window after the new node is linked to the front of the chain during
which its chain pointer is incorrect.

  Not OK for head?

    cheers,
      DaveK



--------------030707010101040107020500
Content-Type: text/x-c;
 name="pthread-interlocked-asms-v2.diff"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="pthread-interlocked-asms-v2.diff"
Content-length: 2038

SW5kZXg6IHdpbnN1cC9jeWd3aW4vd2luYmFzZS5oCj09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT0KUkNTIGZpbGU6IC9jdnMvc3JjL3NyYy93aW5zdXAvY3lnd2lu
L3dpbmJhc2UuaCx2CnJldHJpZXZpbmcgcmV2aXNpb24gMS4xNApkaWZmIC1w
IC11IC1yMS4xNCB3aW5iYXNlLmgKLS0tIHdpbnN1cC9jeWd3aW4vd2luYmFz
ZS5oCTEyIEp1bCAyMDA4IDE4OjA5OjE3IC0wMDAwCTEuMTQKKysrIHdpbnN1
cC9jeWd3aW4vd2luYmFzZS5oCTMgSnVuIDIwMDkgMjI6NTQ6MzggLTAwMDAK
QEAgLTM0LDI3ICszNCwzMSBAQCBpbG9ja2RlY3IgKHZvbGF0aWxlIGxvbmcg
Km0pCiAJIjogIj0mciIgKF9fcmVzKSwgIj1tIiAoKm0pOiAibSIgKCptKTog
ImNjIik7CiAgIHJldHVybiBfX3JlczsKIH0KLQotZXh0ZXJuIF9faW5saW5l
X18gbG9uZwotaWxvY2tleGNoICh2b2xhdGlsZSBsb25nICp0LCBsb25nIHYp
Ci17Ci0gIHJlZ2lzdGVyIGludCBfX3JlczsKLSAgX19hc21fXyBfX3ZvbGF0
aWxlX18gKCJcblwKLTE6CWxvY2sJY21weGNoZ2wgJTMsKCUxKVxuXAotCWpu
ZSAxYlxuXAotIAkiOiAiPWEiIChfX3JlcyksICI9cSIgKHQpOiAiMSIgKHQp
LCAicSIgKHYpLCAiMCIgKCp0KTogImNjIik7Ci0gIHJldHVybiBfX3JlczsK
LX0KLQotZXh0ZXJuIF9faW5saW5lX18gbG9uZwotaWxvY2tjbXBleGNoICh2
b2xhdGlsZSBsb25nICp0LCBsb25nIHYsIGxvbmcgYykKLXsKLSAgcmVnaXN0
ZXIgaW50IF9fcmVzOwotICBfX2FzbV9fIF9fdm9sYXRpbGVfXyAoIlxuXAot
CWxvY2sgY21weGNoZ2wgJTMsKCUxKVxuXAotCSI6ICI9YSIgKF9fcmVzKSwg
Ij1xIiAodCkgOiAiMSIgKHQpLCAicSIgKHYpLCAiMCIgKGMpOiAiY2MiKTsK
LSAgcmV0dXJuIF9fcmVzOwotfQorDQorZXh0ZXJuIF9faW5saW5lX18gbG9u
Zw0KK2lsb2NrZXhjaCAodm9sYXRpbGUgbG9uZyAqdCwgbG9uZyB2KQ0KK3sN
CisgIHJldHVybiAoew0KKwkJX190eXBlb2YgKCp0KSByZXQ7DQorCQlfX2Fz
bSBfX3ZvbGF0aWxlICgiMToJbG9jayBjbXB4Y2hnbCAlMiwgJTFcbiINCisJ
CQkJIglqbmUgMWJcbiINCisJCQk6ICI9YSIgKHJldCksICI9bSIgKCp0KQ0K
KwkJCTogInIiICh2KSwgIm0iICgqdCksICIwIiAoKnQpKTsNCisJCXJldDsN
CisJfSk7DQorfQ0KKw0KK2V4dGVybiBfX2lubGluZV9fIGxvbmcNCitpbG9j
a2NtcGV4Y2ggKHZvbGF0aWxlIGxvbmcgKnQsIGxvbmcgdiwgbG9uZyBjKQ0K
K3sNCisgIHJldHVybiAoew0KKwkJX190eXBlb2YgKCp0KSByZXQ7DQorCQlf
X2FzbSBfX3ZvbGF0aWxlICgibG9jayBjbXB4Y2hnbCAlMiwgJTEiDQorCQkJ
OiAiPWEiIChyZXQpLCAiPW0iICgqdCkNCisJCQk6ICJyIiAodiksICJtIiAo
KnQpLCAiMCIgKGMpKTsNCisJCXJldDsNCisJfSk7DQorfQ0KIAogI3VuZGVm
IEludGVybG9ja2VkSW5jcmVtZW50CiAjZGVmaW5lIEludGVybG9ja2VkSW5j
cmVtZW50IGlsb2NraW5jcgo=

--------------030707010101040107020500--
