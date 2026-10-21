Return-Path: <SRS0=mRRK=IL=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e09.mail.nifty.com (mta-snd-e09.mail.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:29])
	by sourceware.org (Postfix) with ESMTPS id 06BC04BA23E7
	for <cygwin-patches@cygwin.com>; Wed, 21 Oct 2026 13:29:00 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 06BC04BA23E7
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 06BC04BA23E7
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2001:268:fa04:731:6a:99:e2:29
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1792589341; cv=none;
	b=UgptUtvbo/+NvFKmC64kF9X2vdMMyAZlInk89sEw1e6RdKQy9mELULNhVfJpYzVX0ZGNq9wO1eICkT7grXCvHku3PCJpVV1nXVN0jcg87P1Sc26El6ttSvw0+8JRRd0nbKhXOX/ZgQoRQQZCoJNOdGd5H/whrineiqZPUseC/9w=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1792589341; c=relaxed/simple;
	bh=2vqLsdlm0jULMUWbkcWPOLUX/x/Gj4sTzln2JBTE3eM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=BZR29IrP6bljJCIxzXft69sSDCgD3YJ7ZImv0DiYO3Z5oA4udOVmW3uBJlmDz8Rbh7jJDtWFdnxXjIYM60XcoKUKxh8waNTtMiXfkt767jDxOIWH8XcTVJI51F9tktCVEBygGIlYBkFLkV3A3HkY2m+uNAzDdhkeRqoU7fiR31k=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=PBYJxYUS
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 06BC04BA23E7
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=PBYJxYUS
Received: from HP-Z230 by mta-snd-e09.mail.nifty.com with ESMTP
          id <20261021132858684.FTMQ.60338.HP-Z230@nifty.com>;
          Wed, 21 Oct 2026 22:28:58 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v4] Cygwin: oss: Implement /dev/sequencer and /dev/midi
Date: Wed, 21 Oct 2026 22:28:35 +0900
Message-ID: <20261021132849.64172-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1792589338;
 bh=RC1Muo3NWkzv9NdPIMfYCOLb9SmqmWmUthUaZmRf86A=;
 h=From:To:Cc:Subject:Date;
 b=PBYJxYUSVvGe8i3B0hTKfASJreGvq/dlkHMNXo1vKw4+JpQDXtXdA4USKIOyzuswKR1Vk0/8
 gpWmJnCacZOBonTBFlcYEESBALM1OH9qE1nVvBnl8yhuJcDaY0kvfRwkOzthVplsw3/X0kfZrQ
 toAYhRuDBMl9yo44PVUzzNN9jYGJf3IxfUXhkePGJ0+smS9dtTovdpjGeA7hje9aPyZpPnOEZa
 dAV7u0B+F+tv8noziUcuusg+VIiv48EHMq/IY2sAzkh9E4X8VoDliYQh1Up6Zlb81UDkv1P0MT
 naW+fcnwraKmMkIdLWNN8+gbC0diXZQ5SD2hVkTz3+iQPQVA==
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SH_BODYURI_REVERSE_DROP,SH_BODYURI_REVERSE_SBL,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_SBL_A shortcircuit=no autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is an experimental implementation of /dev/sequencer and
/dev/midi* for the external MIDI devices. Currently, only output
is supported for /dev/sequencer, while /dev/midi* can be used
for both output and input.

TODO:
  - Add support for non-blocking read()
  - Support select()
  - Implement input (read) for /dev/sequencer

Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
v2: Use archetype
v3: Add /dev/midi*. Fix a few bugs regarding archetype handling.
v4: Implement input (read) for /dev/midi*

 winsup/cygwin/Makefile.am               |     2 +
 winsup/cygwin/autoload.cc               |    15 +
 winsup/cygwin/devices.cc                | 10270 ++++++++++++++++------
 winsup/cygwin/devices.in                |     9 +
 winsup/cygwin/dtable.cc                 |    23 +-
 winsup/cygwin/fhandler/midi.cc          |   344 +
 winsup/cygwin/fhandler/sequencer.cc     |   381 +
 winsup/cygwin/local_includes/devices.h  |     2 +
 winsup/cygwin/local_includes/fhandler.h |   129 +
 9 files changed, 8683 insertions(+), 2492 deletions(-)
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
index 7054511b6..52d646fdf 100644
--- a/winsup/cygwin/autoload.cc
+++ b/winsup/cygwin/autoload.cc
@@ -730,6 +730,21 @@ LoadDLLfuncEx3 (waveOutUnprepareHeader, winmm, 1, 0, 1)
 LoadDLLfuncEx3 (waveOutWrite, winmm, 1, 0, 1)
 LoadDLLfuncEx3 (waveOutMessage, winmm, 1, 0, 1)
 LoadDLLfuncEx3 (waveOutGetDevCapsA, winmm, 1, 0, 1)
+LoadDLLfuncEx3 (midiInGetNumDevs, winmm, 1, 0, 1)
+LoadDLLfuncEx3 (midiInOpen, winmm, 1, 0, 1)
+LoadDLLfuncEx3 (midiInClose, winmm, 1, 0, 1)
+LoadDLLfuncEx3 (midiInStart, winmm, 1, 0, 1)
+LoadDLLfuncEx3 (midiInStop, winmm, 1, 0, 1)
+LoadDLLfuncEx3 (midiInPrepareHeader, winmm, 1, 0, 1)
+LoadDLLfuncEx3 (midiInUnprepareHeader, winmm, 1, 0, 1)
+LoadDLLfuncEx3 (midiInAddBuffer, winmm, 1, 0, 1)
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
index 000000000..5707b4e00
--- /dev/null
+++ b/winsup/cygwin/fhandler/midi.cc
@@ -0,0 +1,344 @@
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
+#include "shared_info.h"
+#include <mmddk.h>
+
+static void CALLBACK
+midi_in_proc (HMIDIIN h_in, UINT msg, DWORD_PTR instance,
+	      DWORD_PTR param1, DWORD_PTR param2)
+{
+  fhandler_dev_midi::midi_in *fh = (fhandler_dev_midi::midi_in *) instance;
+  fh->midi_in_proc (msg, param1, param2);
+}
+
+void
+fhandler_dev_midi::midi_in::midi_in_proc (UINT msg,
+					  DWORD_PTR param1, DWORD_PTR param2)
+{
+  unsigned char *p = (unsigned char *) &param1;
+  DWORD n;
+  WaitForSingleObject (mtx, INFINITE);
+  switch (msg)
+    {
+    case MIM_DATA:
+//system_printf ("%02x, %02x, %02x, %08x\r", p[0], p[1], p[2], param2);
+      switch (p[0] & 0xf0)
+	{
+	case 0x80: /* Note off */
+	case 0x90: /* Note on */
+	case 0xa0: /* Polyphonic key pressure */
+	case 0xb0: /* Control change */
+	case 0xe0: /* Pitch wheel change */
+	  WriteFile (hw, p, 3, &n, NULL);
+	  SetEvent (ev);
+	  break;
+	case 0xc0: /* Program change */
+	case 0xd0: /* Channel pressure */
+	  WriteFile (hw, p, 2, &n, NULL);
+	  SetEvent (ev);
+	  break;
+	case 0xf0:
+	  switch (p[0] & 0x0f)
+	    {
+	    case 0x0: /* System exclusive message */
+	    case 0x7: /* End of system exclusive message */
+	      system_printf("SysEx in MIM_DATA. Shall not be happen.\r");
+	      break;
+	    case 0x1: /* MIDI time code */
+	    case 0x3: /* Song Select */
+	      WriteFile (hw, p, 2, &n, NULL);
+	      SetEvent (ev);
+	      break;
+	    case 0x2: /* Song position */
+	      WriteFile (hw, p, 3, &n, NULL);
+	      SetEvent (ev);
+	      break;
+	    case 0x6: /* Tune request */
+	    case 0x8: /* MIDI clock */
+	    case 0xa: /* Sequence start */
+	    case 0xb: /* Sequence continue */
+	    case 0xc: /* Sequence stop */
+	    case 0xe: /* Active Sensing */
+	    case 0xf: /* Reset */
+	      WriteFile (hw, p, 1, &n, NULL);
+	      SetEvent (ev);
+	      break;
+	    default: /* 0x4, 0x5, 0x9, 0xd */
+	      /* Undefined. Ignore. */;
+	    }
+	}
+      break;
+    case MIM_LONGDATA:
+//system_printf ("%d: %02x, ... %02x\r", hdr->dwBytesRecorded, buf[0], buf[hdr->dwBytesRecorded - 1]);
+      WriteFile (hw, buf, hdr->dwBytesRecorded, &n, NULL);
+      SetEvent (ev);
+      hdr->dwFlags = 0;
+      midiInPrepareHeader (h_in, hdr, sizeof (MIDIHDR));
+      midiInAddBuffer(h_in, hdr, sizeof (MIDIHDR));
+    default:
+      break;
+    }
+  ReleaseMutex (mtx);
+}
+
+void
+fhandler_dev_midi::midi_in::open (int id, bool full_open)
+{
+  if (full_open)
+    {
+      char name[MAX_PATH];
+      CreatePipe (&hr, &hw, &sec_none, 0);
+      shared_name (name, "cygoss.midi_in.mutex", id);
+      mtx = CreateMutex (&sec_none, FALSE, name);
+      ev = CreateEvent (&sec_none, TRUE, FALSE, NULL);
+    }
+  midiInOpen (&h_in, id, (DWORD_PTR) ::midi_in_proc, (DWORD_PTR) this,
+	      CALLBACK_FUNCTION);
+  midiInStart (h_in);
+  hdr = new MIDIHDR;
+  hdr->lpData = (char *) buf;
+  hdr->dwBufferLength = sizeof (buf);
+  hdr->dwFlags = 0;
+  midiInPrepareHeader (h_in, hdr, sizeof (MIDIHDR));
+  midiInAddBuffer(h_in, hdr, sizeof (MIDIHDR));
+}
+
+void
+fhandler_dev_midi::midi_in::close ()
+{
+  midiInStop (h_in);
+  midiInClose (h_in);
+  midiInUnprepareHeader (h_in, (MIDIHDR *) hdr, sizeof (MIDIHDR));
+  delete hdr;
+  midiInClose (h_in);
+  CloseHandle (hw);
+  CloseHandle (hr);
+  CloseHandle (mtx);
+}
+
+static bool
+bytes_available (DWORD& n, HANDLE h)
+{
+  DWORD navail, nleft;
+  navail = nleft = 0;
+  bool succeeded = PeekNamedPipe (h, NULL, 0, NULL, &navail, &nleft);
+  if (succeeded)
+    /* nleft should always be the right choice unless something has written 0
+       bytes to the pipe.  In that pathological case we return the actual number
+       of bytes available in the pipe. See cgf-000008 for more details.  */
+    n = nleft ?: navail;
+  else
+    {
+      termios_printf ("PeekNamedPipe(%p) failed, %E", h);
+      n = 0;
+    }
+  debug_only_printf ("n %u, nleft %u, navail %u", n, nleft, navail);
+  return succeeded;
+}
+
+void
+fhandler_dev_midi::midi_in::read (void *ptr, size_t& len)
+{
+  DWORD n, m;
+  DWORD total_read = 0;
+  char *buf = (char *) ptr;
+  cygwait (ev, INFINITE);
+  WaitForSingleObject (mtx, INFINITE);
+  while (::bytes_available (m, hr) && m && total_read < len)
+    {
+      ReadFile (hr, buf + total_read, len - total_read, &n, NULL);
+      total_read += n;
+    }
+  if (m == 0)
+    ResetEvent (ev);
+  ReleaseMutex (mtx);
+  len = total_read;
+}
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
+  dev_in.read (ptr, len);
+}
+
+int
+fhandler_dev_midi::open (int flags, mode_t)
+{
+  int ret = -1;
+  switch (flags & O_ACCMODE)
+    {
+    case O_RDWR:
+      dev_in.open (get_minor () >> 8);
+      fallthrough;
+    case O_WRONLY:
+      dev_out.open (get_minor () >> 8);
+      ret = open_null (flags);
+      break;
+    case O_RDONLY:
+      dev_in.open (get_minor () >> 8);
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
+  int acc_mode = get_flags () & O_ACCMODE;
+  if (acc_mode == O_RDWR || acc_mode == O_RDONLY)
+    dev_in.close ();
+  if (acc_mode == O_RDWR || acc_mode == O_WRONLY)
+    dev_out.close ();
+  return fhandler_base::close (flag);
+}
+
+void
+fhandler_dev_midi::fixup_after_fork (HANDLE parent)
+{
+  int acc_mode = get_flags () & O_ACCMODE;
+  if (acc_mode == O_RDWR || acc_mode == O_RDONLY)
+    dev_in.open (get_minor () >> 8, false);
+  if (acc_mode == O_RDWR || acc_mode == O_WRONLY)
+    dev_out.open (get_minor () >> 8);
+}
+
+void
+fhandler_dev_midi::fixup_after_exec ()
+{
+  if (!close_on_exec ())
+    {
+      int acc_mode = get_flags () & O_ACCMODE;
+      CoInitialize (NULL);
+      if (acc_mode == O_RDWR || acc_mode == O_RDONLY)
+	dev_in.open (get_minor () >> 8);
+      if (acc_mode == O_RDWR || acc_mode == O_WRONLY)
+	dev_out.open (get_minor () >> 8);
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
index 766bb0c91..d6130f067 100644
--- a/winsup/cygwin/local_includes/fhandler.h
+++ b/winsup/cygwin/local_includes/fhandler.h
@@ -2857,6 +2857,135 @@ class fhandler_dev_mixer: public fhandler_base
   }
 };
 
+class fhandler_dev_midi: public fhandler_base
+{
+public:
+  class midi_in {
+  private:
+    struct HMIDIIN__ *h_in;
+    unsigned char buf[4096];
+    struct midihdr_tag *hdr;
+    HANDLE mtx;
+    HANDLE hw;
+    HANDLE hr;
+    HANDLE ev;
+  public:
+    void open (int, bool full_open = true);
+    void close ();
+    void midi_in_proc (UINT, DWORD_PTR, DWORD_PTR);
+    void read (void *, size_t&);
+  };
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
+private:
+  midi_in dev_in;
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

