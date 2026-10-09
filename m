Return-Path: <SRS0=GLxl=H7=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.226.37])
	by sourceware.org (Postfix) with ESMTPS id A90CF4BA543C
	for <cygwin-patches@cygwin.com>; Fri,  9 Oct 2026 04:40:25 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A90CF4BA543C
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A90CF4BA543C
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.226.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1791520826; cv=none;
	b=AXEWe8DnSuOug7JMI7oRDpqU2+HsYTFb2kzova17azOgqI/VD9A89kNu+9G2aE0phzUx6ddl6wuxjY6+xrQxEDnzKTmnDn2c+WTAHpXkIjWYvSslXXneMDhk2jORgWdhW0hajVCBTt73kixPo+8W14CnQTeZ+ryuTO6dazRBbEE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1791520826; c=relaxed/simple;
	bh=TmerGzwrZuW+AYgPXSCrMb0cE4wBbk41SGzN1n9ynAo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=EUuLon3DsDIThQzQBVueGsGavqzbn225hIQVM69IGUXwC2zMh9+/wI5q4cwpMsSDaWBr8EFRUSMY8lVHEwG2ujMgr4MmtYE+7K/Twou6X1DN1SJAwxu2Jz2ttIt7Cn4uQpDTTbkmKZGKyUY6EFZ5V/O9C8CZUsx0uy88afIH40g=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=arxfUApx
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A90CF4BA543C
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=arxfUApx
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20261009044023237.YQRR.102121.HP-Z230@nifty.com>;
          Fri, 9 Oct 2026 13:40:23 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v3] Cygwin: sequencer: Implement /dev/sequencer, /dev/midi
Date: Fri,  9 Oct 2026 13:40:08 +0900
Message-ID: <20261009044016.175-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1791520823;
 bh=OrL3e5vtr3eGGwyiHhP4EYLguLsKtNF1oUTeuMvFY4g=;
 h=From:To:Cc:Subject:Date;
 b=arxfUApxwPgi4o1kHmMLiEIP2ttsPUj3+gOgbNblRWU7APZ5SEnbOwaThUoJcXuMZDgzAf4D
 LzLZcSHcUqBebG6uQRv7yCzM0H69q+l40ybWHsLSnvRYZesg+l1lL5yP/4VJO6rhUtpuQOKrCc
 9wgsFcTtK8g6BT+3IvGkasmE30apkugg4dPvRHyTp9jJ+h1jaC8qeegqIxaYLgV9FM/+mFCGvB
 v1/B0tAbl2PQSSHaTPD7eNPVXCYA48LwxUzwTSKua/oEBIkEOnn44m0npUkGU7iktBCFMk05Nw
 iX9oOeA/Fe5qgU24VAwoLHCF5r1qhePkzf4XG2vcg4C0O6tg==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SH_BODYURI_REVERSE_DROP,SH_BODYURI_REVERSE_SBL,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_SBL_A shortcircuit=no autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is an experimental implementation of /dev/sequencer and
/dev/midi* for the external MIDI devices. Currently, only output
is supported.

Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
v2: Use archetype
v3: Add /dev/midi*. Fix a few bugs regarding archetype handling.

 winsup/cygwin/Makefile.am               |     2 +
 winsup/cygwin/autoload.cc               |     8 +
 winsup/cygwin/devices.cc                | 10270 ++++++++++++++++------
 winsup/cygwin/devices.in                |     9 +
 winsup/cygwin/dtable.cc                 |    23 +-
 winsup/cygwin/fhandler/midi.cc          |   174 +
 winsup/cygwin/fhandler/sequencer.cc     |   381 +
 winsup/cygwin/local_includes/devices.h  |     2 +
 winsup/cygwin/local_includes/fhandler.h |   112 +
 9 files changed, 8489 insertions(+), 2492 deletions(-)
 create mode 100644 winsup/cygwin/fhandler/midi.cc
 create mode 100644 winsup/cygwin/fhandler/sequencer.cc

diff --git a/winsup/cygwin/Makefile.am b/winsup/cygwin/Makefile.am
index 22b7b14bd..4b9e8f904 100644
--- a/winsup/cygwin/Makefile.am
+++ b/winsup/cygwin/Makefile.am
@@ -98,6 +98,7 @@ FHANDLER_FILES= \
 	fhandler/dsp.cc \
 	fhandler/fifo.cc \
 	fhandler/floppy.cc \
+	fhandler/midi.cc \
 	fhandler/mixer.cc \
 	fhandler/mqueue.cc \
 	fhandler/netdrive.cc \
@@ -114,6 +115,7 @@ FHANDLER_FILES= \
 	fhandler/raw.cc \
 	fhandler/registry.cc \
 	fhandler/serial.cc \
+	fhandler/sequencer.cc \
 	fhandler/signalfd.cc \
 	fhandler/socket.cc \
 	fhandler/socket_inet.cc \
diff --git a/winsup/cygwin/autoload.cc b/winsup/cygwin/autoload.cc
index 7054511b6..4558957cd 100644
--- a/winsup/cygwin/autoload.cc
+++ b/winsup/cygwin/autoload.cc
@@ -730,6 +730,14 @@ LoadDLLfuncEx3 (waveOutUnprepareHeader, winmm, 1, 0, 1)
 LoadDLLfuncEx3 (waveOutWrite, winmm, 1, 0, 1)
 LoadDLLfuncEx3 (waveOutMessage, winmm, 1, 0, 1)
 LoadDLLfuncEx3 (waveOutGetDevCapsA, winmm, 1, 0, 1)
+LoadDLLfuncEx3 (midiInGetNumDevs, winmm, 1, 0, 1)
+LoadDLLfuncEx3 (midiOutGetNumDevs, winmm, 1, 0, 1)
+LoadDLLfuncEx3 (midiOutOpen, winmm, 1, 0, 1)
+LoadDLLfuncEx3 (midiOutClose, winmm, 1, 0, 1)
+LoadDLLfuncEx3 (midiOutShortMsg, winmm, 1, 0, 1)
+LoadDLLfuncEx3 (midiOutLongMsg, winmm, 1, 0, 1)
+LoadDLLfuncEx3 (midiOutPrepareHeader, winmm, 1, 0, 1)
+LoadDLLfuncEx3 (midiOutUnprepareHeader, winmm, 1, 0, 1)
 
 LoadDLLfunc (accept, ws2_32)
 LoadDLLfunc (bind, ws2_32)
diff --git a/winsup/cygwin/devices.in b/winsup/cygwin/devices.in
index ea9a70e1b..022b72130 100644
--- a/winsup/cygwin/devices.in
+++ b/winsup/cygwin/devices.in
@@ -65,6 +65,13 @@ exists_ntdev_silent (const device& dev)
   return exists_ntdev (dev) ? -1 : false;
 }
 
+static int
+exists_midi (const device& dev)
+{
+  unsigned int n = dev.get_minor () >> 8;
+  return (n < min (max (midiInGetNumDevs (), midiOutGetNumDevs ()), 256U));
+}
+
 static int
 exists_console (const device& dev)
 {
@@ -169,6 +176,8 @@ const _device dev_error_storage =
 "/dev/ptmx", BRACK(FH_PTMX), "/dev/ptmx", exists, S_IFCHR
 "/dev/windows", BRACK(FH_WINDOWS), "\\Device\\Null", exists_ntdev, S_IFCHR
 "/dev/mixer", BRACK(FH_OSS_MIXER), "\\Device\\Null", exists_ntdev, S_IFCHR
+"/dev/sequencer", BRACK(FH_OSS_SEQUENCER), "\\Device\\Null", exists_ntdev, S_IFCHR
+"/dev/midi%(0-255)d", BRACK(FH_OSS_MIDI0 | {$1 << 8}), "\\Device\\Null", exists_midi, S_IFCHR
 "/dev/dsp", BRACK(FH_OSS_DSP), "\\Device\\Null", exists_ntdev, S_IFCHR
 "/dev/conin", BRACK(FH_CONIN), "/dev/conin", exists_console, S_IFCHR
 "/dev/conout", BRACK(FH_CONOUT), "/dev/conout", exists_console, S_IFCHR
diff --git a/winsup/cygwin/dtable.cc b/winsup/cygwin/dtable.cc
index 530c67910..42140bd34 100644
--- a/winsup/cygwin/dtable.cc
+++ b/winsup/cygwin/dtable.cc
@@ -510,6 +510,23 @@ fh_alloc (path_conv& pc)
     case DEV_CONS_MAJOR:
       fh = cnew (fhandler_console, pc.dev);
       break;
+    case DEV_SOUND_MAJOR:
+      switch ((dev_t) pc.dev)
+	{
+	case FH_OSS_MIXER:
+	  fh = cnew (fhandler_dev_mixer);
+	  break;
+	case FH_OSS_SEQUENCER:
+	  fh = cnew (fhandler_dev_sequencer);
+	  break;
+	case FH_OSS_DSP:
+	  fh = cnew (fhandler_dev_dsp);
+	  break;
+	default: /* MIDI */
+	  fh = cnew (fhandler_dev_midi, pc.dev);
+	  break;
+	}
+      break;
     default:
       switch ((dev_t) pc.dev)
 	{
@@ -563,12 +580,6 @@ fh_alloc (path_conv& pc)
 	case FH_CLIPBOARD:
 	  fh = cnew (fhandler_dev_clipboard);
 	  break;
-	case FH_OSS_MIXER:
-	  fh = cnew (fhandler_dev_mixer);
-	  break;
-	case FH_OSS_DSP:
-	  fh = cnew (fhandler_dev_dsp);
-	  break;
 	case FH_PROC:
 	  fh = cnew (fhandler_proc);
 	  break;
diff --git a/winsup/cygwin/fhandler/midi.cc b/winsup/cygwin/fhandler/midi.cc
new file mode 100644
index 000000000..d37f56c7b
--- /dev/null
+++ b/winsup/cygwin/fhandler/midi.cc
@@ -0,0 +1,174 @@
+/* fhandler_dev_midi: code to emulate OSS sound model /dev/midi
+
+   Written by Takashi Yano <takashi.yano@nifty.ne.jp>
+
+This file is part of Cygwin.
+
+This software is a copyrighted work licensed under the terms of the
+Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
+details. */
+
+#include "winsup.h"
+#include <sys/soundcard.h>
+#include "cygerrno.h"
+#include "path.h"
+#include "fhandler.h"
+#include "dtable.h"
+#include "cygheap.h"
+#include <mmddk.h>
+
+void
+fhandler_dev_midi::midi_out::reset ()
+{
+  buf_len = 0;
+  msg_len = -1;
+}
+
+void
+fhandler_dev_midi::midi_out::open (int id)
+{
+  reset ();
+  if (MMSYSERR_NOERROR != midiOutOpen (&h_out, id, 0, 0, CALLBACK_NULL))
+    h_out = NULL;
+}
+
+void
+fhandler_dev_midi::midi_out::close ()
+{
+  if (h_out)
+    midiOutClose (h_out);
+  h_out = NULL;
+}
+
+void
+fhandler_dev_midi::midi_out::putc (unsigned char c)
+{
+  if (buf_len >= sizeof (buf))
+    return;
+  if (c & 0x80)
+    {
+      switch (c & 0xf0)
+	{
+	case 0x80: /* Note off */
+	case 0x90: /* Note on */
+	case 0xa0: /* Polyphonic key pressure */
+	case 0xb0: /* Control change */
+	case 0xe0: /* Pitch wheel change */
+	  buf_len = 0;
+	  msg_len = 3;
+	  buf[buf_len++] = c;
+	  break;
+	case 0xc0: /* Program change */
+	case 0xd0: /* Channel pressure */
+	  buf_len = 0;
+	  msg_len = 2;
+	  buf[buf_len++] = c;
+	  break;
+	case 0xf0:
+	  switch (c & 0x0f)
+	    {
+	    case 0x0: /* System exclusive message */
+	      buf_len = 0;
+	      msg_len = -1;
+	      buf[buf_len++] = c;
+	      break;
+	    case 0x1: /* MIDI time code */
+	    case 0x3: /* Song Select */
+	      buf_len = 0;
+	      msg_len = 2;
+	      buf[buf_len++] = c;
+	      break;
+	    case 0x2: /* Song position */
+	      buf_len = 0;
+	      msg_len = 3;
+	      buf[buf_len++] = c;
+	      break;
+	    case 0x6: /* Tune request */
+	    case 0x8: /* MIDI clock */
+	    case 0xa: /* Sequence start */
+	    case 0xb: /* Sequence continue */
+	    case 0xc: /* Sequence stop */
+	    case 0xe: /* Active Sensing */
+	    case 0xf: /* Reset */
+	      buf_len = 0;
+	      msg_len = 1;
+	      buf[buf_len++] = c;
+	      break;
+	    case 0x7: /* End of system exclusive message */
+	      buf[buf_len++] = c;
+		{
+		  MIDIHDR hdr = {0, };
+		  hdr.lpData = (char *) buf;
+		  hdr.dwBufferLength = buf_len;
+		  hdr.dwBytesRecorded = buf_len;
+		  midiOutPrepareHeader (h_out, &hdr, sizeof (hdr));
+		  midiOutLongMsg (h_out, &hdr, sizeof (hdr));
+		  midiOutUnprepareHeader (h_out, &hdr, sizeof (hdr));
+		}
+	      break;
+	    default: /* 0x4, 0x5, 0x9, 0xd */
+	      /* Undefined. Ignore. */;
+	    }
+	}
+    }
+  else
+    buf[buf_len++] = c;
+  if (buf_len == msg_len && h_out)
+    midiOutShortMsg (h_out, *(LPDWORD) buf);
+}
+
+ssize_t
+fhandler_dev_midi::write (const void *ptr, size_t len)
+{
+  const unsigned char *p = (const unsigned char *) ptr;
+  for (size_t i = 0; i < len; i++)
+    dev_out.putc (p[i]);
+  return len;
+}
+
+void
+fhandler_dev_midi::read (void *ptr, size_t& len)
+{
+  len = -1;
+  set_errno (EINVAL);
+}
+
+int
+fhandler_dev_midi::open (int flags, mode_t)
+{
+  int ret = -1;
+  switch (flags & O_ACCMODE)
+    {
+    case O_RDWR:
+    case O_WRONLY:
+      dev_out.open (get_minor () >> 8);
+      ret = open_null (flags);
+      break;
+    default:
+      set_errno (ENXIO);
+    }
+  return ret;
+}
+
+int
+fhandler_dev_midi::close (int flag)
+{
+  dev_out.close ();
+  return fhandler_base::close (flag);
+}
+
+void
+fhandler_dev_midi::fixup_after_fork (HANDLE parent)
+{
+  dev_out.open (get_minor () >> 8);
+}
+
+void
+fhandler_dev_midi::fixup_after_exec ()
+{
+  if (!close_on_exec ())
+    {
+      CoInitialize (NULL);
+      dev_out.open (get_minor () >> 8);
+    }
+}
diff --git a/winsup/cygwin/fhandler/sequencer.cc b/winsup/cygwin/fhandler/sequencer.cc
new file mode 100644
index 000000000..7540c9a6d
--- /dev/null
+++ b/winsup/cygwin/fhandler/sequencer.cc
@@ -0,0 +1,381 @@
+/* fhandler_dev_sequencer: code to emulate OSS sound model /dev/sequencer
+
+   Written by Takashi Yano <takashi.yano@nifty.ne.jp>
+
+This file is part of Cygwin.
+
+This software is a copyrighted work licensed under the terms of the
+Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
+details. */
+
+#include "winsup.h"
+#include <sys/soundcard.h>
+#include "cygerrno.h"
+#include "path.h"
+#include "fhandler.h"
+#include "dtable.h"
+#include "cygheap.h"
+#include <mmddk.h>
+
+void
+fhandler_dev_sequencer::midi_putc (int dev, unsigned char c)
+{
+  if (dev < 0 || dev >= num_devices)
+    return;
+  base ()->dev_out[dev].putc (c);
+}
+
+ssize_t
+fhandler_dev_sequencer::write (const void *ptr, size_t len)
+{
+  const unsigned char *p = (const unsigned char *) ptr;
+  ssize_t len1 = (ssize_t) len;
+  unsigned int *timer_param;
+  DWORD t0 = GetTickCount ();
+  DWORD t1;
+  while (len1 > 0)
+    {
+      /* Currently, only the atomic-write is supported */
+      switch (p[0])
+	{
+	  case SEQ_MIDIPUTC:
+	    if (len1 < 4)
+	      /* Unexpected data. Aborted. */
+	      goto err;
+	    midi_putc (p[2], p[1]);
+	    len1 -= 4;
+	    p += 4;
+	    break;
+	  case EV_TIMING:
+	    if (len1 < 8)
+	      /* Unexpected data. Aborted. */
+	      goto err;
+	    switch (p[1])
+	      {
+	      case TMR_START:
+		start_time = t0;
+		last_ticks = 0;
+		timer_is_running = true;
+		break;
+	      case TMR_STOP:
+		last_ticks =
+		  (int) ((t0 - start_time) * (tempo * timebase / 60000.0));
+		start_time -= t0;
+		timer_is_running = false;
+		break;
+	      case TMR_CONTINUE:
+		if (!timer_is_running)
+		  start_time += t0;
+		timer_is_running = true;
+		break;
+	      case TMR_WAIT_ABS:
+		if (!timer_is_running)
+		  break;
+		timer_param = (unsigned int *) (p + 4);
+		t1 = (DWORD)(*timer_param * (60000.0 / (tempo * timebase)));
+		while (GetTickCount () - start_time < t1)
+		  if (cygwait(1) != WAIT_TIMEOUT)
+		    break;;
+		last_ticks = *timer_param;
+		break;
+	      case TMR_WAIT_REL:
+		if (!timer_is_running)
+		  break;
+		timer_param = (unsigned int *) (p + 4);
+		t1 = (DWORD)((last_ticks + *timer_param)
+			     * (60000.0 / (tempo * timebase)));
+		while (GetTickCount () - start_time < t1)
+		  if (cygwait(1) != WAIT_TIMEOUT)
+		    break;;
+		last_ticks += *timer_param;
+		break;
+	      case TMR_TEMPO:
+		timer_param = (unsigned int *) (p + 4);
+		tempo = *timer_param;
+		break;
+	      default:
+		/* Unexpected data. Ignored. */
+		debug_printf ("Unimplemented timer sub-command: 0x%x\r", p[1]);
+		break;
+	      }
+	    len1 -= 8;
+	    p += 8;
+	    break;
+	  case EV_CHN_COMMON:
+	    if (len1 < 8)
+	      /* Unexpected data. Aborted. */
+	      goto err;
+	    switch (p[2])
+	      {
+	      case MIDI_PGM_CHANGE:
+		midi_putc (p[1], 0xc0 | (p[3] & 0x0f));
+		midi_putc (p[1], p[4]);
+		break;
+	      case MIDI_CTL_CHANGE:
+		midi_putc (p[1], 0xb0 | (p[3] & 0x0f));
+		midi_putc (p[1], p[4]);
+		midi_putc (p[1], p[6]);
+		break;
+	      case MIDI_PITCH_BEND:
+		midi_putc (p[1], 0xe0 | (p[3] & 0x0f));
+		midi_putc (p[1], p[6]);
+		midi_putc (p[1], p[7]);
+		break;
+	      case MIDI_CHN_PRESSURE:
+		midi_putc (p[1], 0xd0 | (p[3] & 0x0f));
+		midi_putc (p[1], p[4]);
+		break;
+	      default:
+		/* Unexpected data. Ignored. */
+		debug_printf ("Unimplemented chn-common sub-command: "
+			      "0x%x\r", p[2]);
+		break;
+	      }
+	    len1 -= 8;
+	    p += 8;
+	    break;
+	  case EV_CHN_VOICE:
+	    if (len1 < 8)
+	      /* Unexpected data. Aborted. */
+	      goto err;
+	    switch (p[2])
+	      {
+	      case MIDI_NOTEON:
+		midi_putc (p[1], 0x90 | (p[3] & 0x0f));
+		midi_putc (p[1], p[4]);
+		midi_putc (p[1], p[5]);
+		break;
+	      case MIDI_NOTEOFF:
+		midi_putc (p[1], 0x80 | (p[3] & 0x0f));
+		midi_putc (p[1], p[4]);
+		midi_putc (p[1], p[5]);
+		break;
+	      case MIDI_KEY_PRESSURE:
+		midi_putc (p[1], 0xa0 | (p[3] & 0x0f));
+		midi_putc (p[1], p[4]);
+		midi_putc (p[1], p[5]);
+		break;
+	      default:
+		/* Unexpected data. Ignored. */
+		debug_printf ("Unimplemented chn-voice sub-command: "
+			      "0x%x\r", p[2]);
+		break;
+	      }
+	    len1 -= 8;
+	    p += 8;
+	    break;
+	  case EV_SYSEX:
+	    if (len1 < 8)
+	      /* Unexpected data. Aborted. */
+	      goto err;
+	    midi_putc (p[1], 0xf0);
+	    for (int i = 2; i < 8; i++)
+	      if (p[i] != 0xff)
+		midi_putc (p[1], p[i]);
+	    midi_putc (p[1], 0xf7);
+	    len1 -= 8;
+	    p += 8;
+	    break;
+	  case SEQ_PRIVATE:
+	    debug_printf ("SEQ_PRIVATE unimplemented\r");
+	    len1 -= 8;
+	    p += 8;
+	    break;
+	  case SEQ_EXTENDED:
+	    debug_printf ("SEQ_EXTENDED unimplemented\r");
+	    len1 -= 8;
+	    p += 8;
+	    break;
+	  default:
+	    /* Unexpected data. Aborted. */
+	    debug_printf ("Unimplemented command: 0x%x\r", p[0]);
+	    goto err;
+	}
+    }
+  return len;
+
+err:
+  debug_printf ("Unexpected data. Aborted. (length=%d/%d)\r", len1, len);
+  return len;
+}
+
+void
+fhandler_dev_sequencer::read (void *ptr, size_t& len)
+{
+  len = -1;
+  set_errno (EINVAL);
+}
+
+int
+fhandler_dev_sequencer::open (int flags, mode_t)
+{
+  int ret = -1;
+  switch (flags & O_ACCMODE)
+    {
+    case O_RDWR:
+    case O_WRONLY:
+      num_devices = midiOutGetNumDevs ();
+      if (num_devices > 256)
+	num_devices = 256;
+      if (num_devices == 0)
+	{
+	  set_errno (ENXIO);
+	  goto out;
+	}
+
+      base ()->dev_out = new fhandler_dev_midi::midi_out[num_devices];
+      for (int i = 0; i < num_devices; i++)
+	base ()->dev_out[i].open (i);
+      ret = open_null (flags);
+      tempo = 60;
+      timebase = 100;
+      timer_is_running = false;
+      break;
+    default:
+      set_errno (ENXIO);
+    }
+
+out:
+  return ret;
+}
+
+int
+fhandler_dev_sequencer::close (int flag)
+{
+  for (int i = 0; i < num_devices; i++)
+    base ()->dev_out[i].close ();
+  delete [] base ()->dev_out;
+  return fhandler_base::close (flag);
+}
+
+int
+fhandler_dev_sequencer::ioctl (unsigned int cmd, void *arg)
+{
+  int ret = 0;
+  int *d = (int *) arg;
+  DWORD t0 = GetTickCount ();
+  switch (cmd)
+    {
+    case SNDCTL_SEQ_RESET:
+      tempo = 60;
+      timebase = 100;
+      timer_is_running = false;
+      start_time = 0;
+      last_ticks = 0;
+      for (int i = 0; i < num_devices; i++)
+	base ()->dev_out[i].reset ();
+      break;
+    case SNDCTL_SEQ_NRSYNTHS:
+      if (d)
+	*d = 0;
+      break;
+    case SNDCTL_SEQ_NRMIDIS:
+      if (d)
+	*d = num_devices;
+      break;
+    case SNDCTL_TMR_TIMEBASE:
+      if (d)
+	{
+	  if (*d)
+	    timebase = *d;
+	  else
+	    *d = timebase;
+	}
+      break;
+    case SNDCTL_TMR_TEMPO:
+      if (d)
+	{
+	  if (*d)
+	    tempo = *d;
+	  else
+	    *d = tempo;
+	}
+      break;
+    case SNDCTL_TMR_START:
+      start_time = t0;
+      last_ticks = 0;
+      timer_is_running = true;
+      break;
+    case SNDCTL_TMR_STOP:
+      last_ticks = (int) ((t0 - start_time) * (tempo * timebase / 60000.0));
+      start_time -= t0;
+      timer_is_running = false;
+      break;
+    case SNDCTL_TMR_CONTINUE:
+      if (!timer_is_running)
+	start_time += t0;
+      timer_is_running = true;
+      break;
+    case SNDCTL_SEQ_CTRLRATE:
+      if (d)
+	*d = tempo * timebase / 60;
+      break;
+    case SNDCTL_SEQ_GETTIME:
+      if (d)
+	{
+	  if (timer_is_running)
+	    *d = (int) ((t0 - start_time) * (tempo * timebase / 60000.0));
+	  else
+	    *d = (int) (last_ticks * (tempo * timebase / 60000.0));
+	}
+      break;
+    case SNDCTL_TMR_SOURCE:
+      if (d)
+	{
+	  if (*d && *d != TMR_INTERNAL)
+	    {
+	      set_errno (EINVAL);
+	      ret = -1;
+	    }
+	  else if (*d == 0)
+	    *d = TMR_INTERNAL;
+	}
+      break;
+    case SNDCTL_TMR_SELECT:
+      if (d && *d != 0) /* Only 0 is available */
+	{
+	  set_errno (EINVAL);
+	  ret = -1;
+	}
+      break;
+    case SNDCTL_SEQ_GETOUTCOUNT:
+      if (d)
+	*d = 0;
+      break;
+    case SNDCTL_SEQ_GETINCOUNT:
+      if (d)
+	*d = 0;
+      break;
+    case SNDCTL_SEQ_SYNC:
+      /* Dummy implementation */
+      break;
+    default:
+      debug_printf("Unimplemented ioctl(): 0x%x\r", cmd);
+      set_errno (EINVAL);
+      ret = -1;
+      break;
+    }
+  return ret;
+}
+
+void
+fhandler_dev_sequencer::fixup_after_fork (HANDLE parent)
+{
+  for (int i = 0; i < num_devices; i++)
+    base ()->dev_out[i].open (i);
+}
+
+void
+fhandler_dev_sequencer::fixup_after_exec ()
+{
+  if (!close_on_exec ())
+    {
+      CoInitialize (NULL);
+      num_devices = midiOutGetNumDevs ();
+      if (num_devices > 256)
+	num_devices = 256;
+      base ()->dev_out = new fhandler_dev_midi::midi_out[num_devices];
+      for (int i = 0; i < num_devices; i++)
+	base ()->dev_out[i].open (i);
+    }
+}
diff --git a/winsup/cygwin/local_includes/devices.h b/winsup/cygwin/local_includes/devices.h
index dc4a29b12..23ab7a0b5 100644
--- a/winsup/cygwin/local_includes/devices.h
+++ b/winsup/cygwin/local_includes/devices.h
@@ -243,6 +243,8 @@ enum fh_devices
 
   DEV_SOUND_MAJOR = 14,
   FH_OSS_MIXER = FHDEV (DEV_SOUND_MAJOR, 0),
+  FH_OSS_SEQUENCER = FHDEV (DEV_SOUND_MAJOR, 1),
+  FH_OSS_MIDI0 = FHDEV (DEV_SOUND_MAJOR, 2),
   FH_OSS_DSP = FHDEV (DEV_SOUND_MAJOR, 3),
 
   DEV_SOCK_MAJOR = 30,
diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/local_includes/fhandler.h
index 766bb0c91..e28db61a7 100644
--- a/winsup/cygwin/local_includes/fhandler.h
+++ b/winsup/cygwin/local_includes/fhandler.h
@@ -2857,6 +2857,118 @@ class fhandler_dev_mixer: public fhandler_base
   }
 };
 
+class fhandler_dev_midi: public fhandler_base
+{
+private:
+  class midi_out {
+  private:
+    struct HMIDIOUT__ *h_out;
+    unsigned char buf[4096];
+    size_t msg_len;
+    size_t buf_len;
+  public:
+    void reset ();
+    void open (int);
+    void close ();
+    void putc (unsigned char);
+  };
+  midi_out dev_out;
+public:
+  fhandler_dev_midi (fh_devices fh)
+  {
+    dev ().parse (fh);
+    need_fork_fixup (true);
+  }
+  fhandler_dev_midi (void *) {}
+  bool use_archetype () const { return true; }
+
+  int open (int, mode_t mode = 0);
+  int close (int flag = -1);
+  ssize_t write (const void *, size_t);
+  void read (void *, size_t&);
+
+  void fixup_after_fork (HANDLE);
+  void fixup_after_exec ();
+
+  void copy_from (fhandler_base *x)
+    {
+      pc.free_strings ();
+      *this = *reinterpret_cast<fhandler_dev_midi *> (x);
+      _copy_from_reset_helper ();
+    }
+
+  fhandler_dev_midi *clone (cygheap_types malloc_type = HEAP_FHANDLER)
+    {
+      void *ptr =
+	(void *) ccalloc (malloc_type, 1, sizeof (fhandler_dev_midi));
+      fhandler_dev_midi *fh = new (ptr) fhandler_dev_midi (ptr);
+      fh->copy_from (this);
+      return fh;
+    }
+
+  friend class fhandler_dev_sequencer;
+};
+
+class fhandler_dev_sequencer: public fhandler_base
+{
+private:
+  int num_devices;
+  fhandler_dev_midi::midi_out *dev_out;
+  void midi_putc (int, unsigned char);
+
+  /* Timer stuff */
+  int timebase;
+  int tempo;
+  int last_ticks;
+  DWORD start_time;
+  bool timer_is_running;
+public:
+  fhandler_dev_sequencer ()
+  {
+    dev ().parse (FH_OSS_SEQUENCER);
+    need_fork_fixup (true);
+  }
+  fhandler_dev_sequencer (void *) {}
+
+  bool use_archetype () const { return true; }
+
+  int open (int, mode_t mode = 0);
+  int close (int flag = -1);
+  ssize_t write (const void *, size_t);
+  void read (void *, size_t&);
+  int ioctl (unsigned int, void *);
+
+  fhandler_dev_sequencer *base ()
+  {
+    if (archetype)
+      return (fhandler_dev_sequencer *) archetype;
+    else
+      return this;
+  }
+
+  void fixup_after_fork (HANDLE);
+  void fixup_after_exec ();
+
+  void copy_from (fhandler_base *x)
+    {
+      pc.free_strings ();
+      fhandler_dev_midi::midi_out *dev_out_orig = dev_out;
+      *this = *reinterpret_cast<fhandler_dev_sequencer *> (x);
+      _copy_from_reset_helper ();
+      if (archetype == this)
+        dev_out = dev_out_orig;
+    }
+
+  fhandler_dev_sequencer *clone (cygheap_types malloc_type = HEAP_FHANDLER)
+    {
+      void *ptr =
+	(void *) ccalloc (malloc_type, 1, sizeof (fhandler_dev_sequencer));
+      fhandler_dev_sequencer *fh = new (ptr) fhandler_dev_sequencer (ptr);
+      fh->copy_from (this);
+      return fh;
+    }
+};
+
 class fhandler_dev_dsp: public fhandler_base
 {
  public:
-- 
2.51.0

