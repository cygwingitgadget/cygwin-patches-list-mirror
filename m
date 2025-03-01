Return-Path: <SRS0=hHhH=VU=gmx.de=johannes.schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	by sourceware.org (Postfix) with ESMTPS id 55C5A3858D1E
	for <cygwin-patches@cygwin.com>; Sat,  1 Mar 2025 21:44:00 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 55C5A3858D1E
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 55C5A3858D1E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.15.18
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1740865440; cv=none;
	b=ql5y1+qZV0FT+EN6n39p/+e7q9R+kb9pWni9LhEYYBLdfEtTLmr0snYouL7xigac4xrgfeUvgMY1gKAfV9CpH0gt+Eb8NLDfsU9dLFnQNDxnrU7JgaceeAy8oYn131CVsn2koMA9NmnB2H1dEeggITS8VoO9Fw8FN+7UeVOmc4M=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1740865440; c=relaxed/simple;
	bh=rgoUnnT1Cu+WYips440LfO7P8JWMs386LQ0tBA6++PA=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=PEyrQThwNUQRqe3qciI65JyUXmRoPmMtNF4dXd4M78o2shvy98/VbQD19D2U6uzbzZGNyF3W7LlBfYTuMaY+Ugfvv/193sxNepoWmH1Y2nH5nJBPAh0xeCS+CG+UumomlxMg4jOwU2mhdE1g47o9dzUqXnlk8cfyJXZsRF2o2Y4=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 55C5A3858D1E
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=SJBdzXTH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1740865439; x=1741470239;
	i=johannes.schindelin@gmx.de;
	bh=abCzdzmm7D9y5DFLFJGzJ9jyAYe93Wpd/GuVh+gpE3g=;
	h=X-UI-Sender-Class:Date:From:To:Subject:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=SJBdzXTH38sHU58eVHlqyvZp3goNVhFDyJwZfK+V73WPQG5iUtkFn9qLOtlU+qJZ
	 +7O8eykFSo27AZWBTlnxjsGXw46h1vhcM3fGrHnR8nFjfms/phpntru8UtwZ9T8+t
	 FXecXk/2HxrYv7gB9In8ObjN+FMhBBZBl6DQB2pegwl/nTues98TEd/ZTaBLpVhe1
	 y4TcgylX+DoyFPF6UCrm6js5cVvkApnZ+2uui35v9CG1muMFRGeYxmZCHNwtTgxeV
	 QNWDxvfhkXhSYkjOWgHEZlp070F0o5xf9YNhQy8hAz0CMia0C5B/BqnEPovSZRPqS
	 Q+p4qdiyZvMQIf0naQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.213.101]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mr9Bk-1tT7hx05Ze-00d2xW for
 <cygwin-patches@cygwin.com>; Sat, 01 Mar 2025 22:43:59 +0100
Date: Sat, 1 Mar 2025 22:43:58 +0100 (CET)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: Adjust CWD magic to accommodate for the latest
 Windows previews
Message-ID: <6449d894879e33af3e8a4791896d2026f7c3f8bd.1740865389.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:U6K2w4loUif5BCalN+w8dP+NCxKB0OR51KvLta76b5L1GYf4g9e
 nq4O0MmHeHnEVTi0Sy51ExD7Eko0VbFYT13XHXgDjBy7oSCCaPRiyOl/NvzY/vyMMEo6DuA
 P915EeU30pvGLJTF0c4+B8zLdRGxu6nmksXhdS7+VjL4S7aB81lsS5EjhplAxh+5CvBxPCo
 HOOMdAs3o5R87E6AlStxA==
UI-OutboundReport: notjunk:1;M01:P0:zrB4kuVq9Xw=;46jATZfle4OQ5uO6/xFXRwb8mrZ
 gAC8mYNCJobWmtMtYJ26n8TRwtb3JlH3Jq/LVScSyybiSpizTGV/56KGILcS+FSDOyVYB+8Uv
 IWMNDU2J+WWF1Sd+acKWXFGnf5TmwhWSnT4qlpUozGoAX8ZQsmMcqRldnjjiXTM8TIE/d1OJj
 571Scvs6jWzneVP79U3vjxIrp1TeVf22sp0/6uGcIDNQ5DUCYclVO19D9eEfA850dCHIDnmtS
 xz5Z2dW76fkG/xzwuhubcm5QaitELi+HWdSLzxBfsaHaU6nBdY+0pC5UQGPGGeTj0gG1FbjA6
 57PpiElZ581EutWzU94p2Kziclwh8EfR03myFx2SBy608t6O7gYsUiY5sdsR/9t4jHWjpWUZr
 PM4HZiBWhg7XZXCDnWOQkrKHwK71D3nbtNxj40SyOhA367vwJBQBILh726exWYaiX5RYYXgSh
 5WvitCzZUu9eHUnv1isqCAuOrcHEK0c2X7mHP1VvKwIvpkJphV1PVguYVDClpjxv/5GkhIoXw
 fqZQKZRwsZrZoMF3E7tUkq7HayUaGr/VZzKlgGP6Zm85pk9tE6phC7QnEQ3f7QYtLd7UPGYSM
 WvEWK19LKq4PU64C4yMR8gTlI0fOvVPhOnLY9JG7ISSkcKPNUza6s+Zd63b1uDLU/vwsUs42t
 beQYW3VqjfqZaF2Y2mFdXNI68dFJrdRYVm/tHysYTVHreKzQca2FiAnzf+iKixUTJyeE4jt2l
 ueCJViYW1eqXqlX1ltmcXbFKWPvaTanJa4KA+HfqUiC/LyEg3ubf7WdYrX2Sp6rYAYfTbb53P
 DoHutzUUhOmzkHpsJGRQzXQdwk49TWYd0khRkmNl9saj1BugNkLG8om/ug/ZR7SIaG0+bxeD7
 GSkBym7oWC7Im1bycFg7NSi64WF6nJQrcCifsMdH+W09minkHdv/m5g2Q4vy95YChkdDhSYT1
 1Gc2eu7eswI8yzBXKpglVDT2AphrIhL8vb/Pljtcfs5+cMbzlL19xSbHvDmFsI/NtjOjWgneX
 sIRXjBvSH5eyunIq0mnWT1RDZU1kC2IUOC3e8yuXXd7WiTQldNODsgsWXHIHOONTB9L/vVlVf
 XX6fzmq4w7bGvtB9o4iCHJMpzexstpXJZDZ7s51pk8Rjr3LWqjxuGCCyKouQPrMNw6YkjEZOp
 x8sdyWi5IRSTwVBLsYDgB6OnGvrwGXnUcO3gNto3ZZX0i3eT/enqrFLb59A2vRylWBwdKngLk
 UOwo3uVAuJVvdqXtibn20bV2TIPE902wjGJ00pVhMx5QnvSEV0w7rvm11wVax8yrRwDdKbAER
 p3kSnVb/dDbhJvLstAw+uXF3DzpMAm/mZ8hhJoj0t5ckCDGQja/SR8r9RpxZ6fLoc3hUUQZG8
 ofasuMBriGd7W48WYc5hZkw46KacnUplK45Eig/k4FLw0glaBDMBtw/F/ZZMvJwuZv8SUAWFT
 GlITv7f6btlW8YxLu0bp51j97aa/42HnNeHv3deORcuOGmcdC
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-12.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Reportedly a very recent internal build of Windows 11 once again changed
the current working directory logic a bit, and Cygwin's "magic" (or:
"technologically sufficiently advanced") code needs to be adjusted
accordingly.

In particular, the following assembly code can be seen:

ntdll!RtlpReferenceCurrentDirectory

  598 00000001`800c6925 488d0db4cd0f00  lea     rcx,[ntdll!FastPebLock (00=
000001`801c36e0)]
  583 00000001`800c692c 4c897810        mov     qword ptr [rax+10h],r15
  588 00000001`800c6930 0f1140c8        movups  xmmword ptr [rax-38h],xmm0
  598 00000001`800c6934 e82774f4ff      call    ntdll!RtlEnterCriticalSect=
ion

The change necessarily looks a bit different than 4840a56325 (Cygwin:
Adjust CWD magic to accommodate for the latest Windows previews,
2023-05-22): The needle `\x48\x8d\x0d` is already present, as the first
version of the hack after Windows 8.1 was released. In that code,
though, the `call` to `RtlEnterCriticalSection` followed the `lea`
instruction immediately, but now there are two more instructions
separating them.

Note: In the long run, we may very well want to follow the insightful
suggestion by a helpful Windows kernel engineer who pointed out that it
may be less fragile to implement kind of a disassembler that has a
better chance to adapt to the ever-changing code of
`ntdll!RtlpReferenceCurrentDirectory` by skipping uninteresting
instructions such as `mov %rsp,%rax`, `mov %rbx,0x20(%rax)`, `push %rsi`
`sub $0x70,%rsp`, etc, and focuses on finding the `lea`, `call
ntdll!RtlEnterCriticalSection` and `mov ..., rbx` instructions, much
like it was prototyped out for ARM64 at
https://gist.github.com/jeremyd2019/aa167df0a0ae422fa6ebaea5b60c80c9

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
Published-As: https://github.com/dscho/msys2-runtime/releases/tag/adjust-f=
ast-cwd-pointer-logic-once-again-cygwin-v1
Fetch-It-Via: git fetch https://github.com/dscho/msys2-runtime adjust-fast=
-cwd-pointer-logic-once-again-cygwin-v1

 winsup/cygwin/path.cc | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
index 599809f941..49740ac465 100644
=2D-- a/winsup/cygwin/path.cc
+++ b/winsup/cygwin/path.cc
@@ -4539,6 +4539,18 @@ find_fast_cwd_pointer ()
          %rcx for the subsequent RtlEnterCriticalSection call. */
       lock =3D (const uint8_t *) memmem ((const char *) use_cwd, 80,
                                        "\x48\x8d\x0d", 3);
+      if (lock)
+	{
+	  /* A recent Windows 11 Preview calls `lea rel(rip),%rcx' then
+	     a `mov` and a `movups` instruction, and only then
+	     `callq RtlEnterCriticalSection'.
+	     */
+	  if (memmem (lock + 7, 8, "\x4c\x89\x78\x10\x0f\x11\x40\xc8", 8))
+	    {
+	      call_rtl_offset =3D 15;
+	    }
+	}
+
       if (!lock)
 	{
 	  /* Windows 8.1 Preview calls `lea rel(rip),%r12' then some unrelated

base-commit: 08e65dd685bec34d4d74f45c06129d271b210bc7
=2D-
2.48.1.windows.1
