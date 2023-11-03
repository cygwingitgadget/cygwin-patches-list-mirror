Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id B44283858428; Fri,  3 Nov 2023 13:27:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B44283858428
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1699018023;
	bh=M7etznn2eXIqF8j6kfXVJ7kU20XyHhObyFwd1vrcSiw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=BRlABrWwa9SihX5HbWypetl/T+FpDHZW8RJ9xXi5NphSrDR+0wf4trbfOqXNdnGTh
	 0bS2op95L8x34p1RglaH7G4X/mUWZcU7zOJWHW/5rfdCXEP/U/gTZzWlkCXn9Szisk
	 gIICa387nMpTNa+nRKOYPMuiFe6M8rTVJdMRVQcw=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id C2B91A80795; Fri,  3 Nov 2023 14:27:01 +0100 (CET)
Date: Fri, 3 Nov 2023 14:27:01 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Christian Franke <Christian.Franke@t-online.de>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Add /dev/disk/by-id symlinks
Message-ID: <ZUT1JUYoh+y3H2wk@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Christian Franke <Christian.Franke@t-online.de>,
	cygwin-patches@cygwin.com
References: <9cf93e3b-36c8-a50c-0154-85f06da29d61@t-online.de>
 <9fd70b83-2364-1e02-555f-dc7b24feff9c@t-online.de>
 <ZUTDd9BH4iysokAl@calimero.vinschen.de>
 <ZUTG5lqjvknVC9ri@calimero.vinschen.de>
 <ZUTVDlCF4q0Qp3QX@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZUTVDlCF4q0Qp3QX@calimero.vinschen.de>
List-Id: <cygwin-patches.cygwin.com>

On Nov  3 12:10, Corinna Vinschen wrote:
> On Nov  3 11:09, Corinna Vinschen wrote:
> > On Nov  3 10:55, Corinna Vinschen wrote:
> > > On Oct  3 14:39, Christian Franke wrote:
> > > > According to NtQueryObject(., ObjectBasicInformation, ...), using
> > > > NtOpenFile(., MAXIMUM_ALLOWED, ...) without admin rights sets GrantedAccess
> > > > to 0x001200a0 (FILE_EXECUTE|FILE_READ_ATTRIBUTES|READ_CONTROL|SYNCHRONIZE).
> > > > For some unknown reason, NVMe drives behind stornvme.sys additionally
> > > > require SYNCHRONIZE to use IOCTL_STORAGE_QUERY_PROPERTY. Possibly a harmless
> > > > bug in the access check somewhere in the NVMe stack.
> > > > 
> > > > The disk scanning from the first patch has been reworked based on code
> > > > borrowed from proc.cc:format_proc_partitions(). For the longer term, it may
> > > > make sense to provide one flexible scanning function for /dev/sdXN,
> > > > /proc/partitions and /proc/disk/by-id.
> > > 
> > > I applied your patch locally (patch looks pretty well, btw) but found
> > > that /dev/disk/by-id is empty, even when running with admin rights.
> > > 
> > > I ran this on Windows 11 and Windows 2K19 in a QEMU/KVM VM.  A
> > > \Device\Harddisk0\Partition0 symlink pointing to \Device\Harddisk0\DR0
> > > exists in both cases.  I straced it, and found the following debug
> > > output:
> > > 
> > >   1015 1155432 [main] ls 361 stordesc_to_id_name: Harddisk0\Partition0: 'Red_Hat' 'VirtIO' '' (ignored)
> > > 
> > > Is that really desired?
> 
> We could fake a serial number dependent on the path.  See
> https://sourceware.org/git/?p=newlib-cygwin.git;a=blob;f=winsup/cygwin/mount.cc;hb=main#l253
> 
> Alternatively, there's also a symlink in GLOBAL?? pointing
> to the same target as \Device\Harddisk0\Partition0, i. e.:
> 
>   \Device\Harddisk0\Partition0 -> \Device\Harddisk0\DR0
> 
> and
> 
>   \GLOBAL??\Disk{4c622943-27e4-e81d-3fc7-c43fc9c7e126} -> \Device\Harddisk0\DR0
> 
> We could use that UUID from that path, but that's quite a hassle
> to grab, because it requires to enumerate GLOBAL??.
> 
> But then again, where does Windows get the UUID from?  Something to
> find out...

I haven't found out where the UUID is coming from, yet, but based on the
description from
https://learn.microsoft.com/en-us/windows-hardware/drivers/storage/device-unique-identifiers--duids--for-storage-devices
I came up with this Q&D solution:

=============== SNIP ================
diff --git a/winsup/cygwin/fhandler/dev_disk.cc b/winsup/cygwin/fhandler/dev_disk.cc
index caca57d63216..74abfb8a3288 100644
--- a/winsup/cygwin/fhandler/dev_disk.cc
+++ b/winsup/cygwin/fhandler/dev_disk.cc
@@ -36,29 +36,51 @@ sanitize_id_string (char *s)
   return i;
 }
 
+typedef struct _STORAGE_DEVICE_UNIQUE_IDENTIFIER {
+  ULONG Version;
+  ULONG Size;
+  ULONG StorageDeviceIdOffset;
+  ULONG StorageDeviceOffset;
+  ULONG DriveLayoutSignatureOffset;
+} STORAGE_DEVICE_UNIQUE_IDENTIFIER, *PSTORAGE_DEVICE_UNIQUE_IDENTIFIER;
+
+typedef struct _STORAGE_DEVICE_LAYOUT_SIGNATURE {
+  ULONG   Version;
+  ULONG   Size;
+  BOOLEAN Mbr;
+  union {
+    ULONG MbrSignature;
+    GUID  GptDiskId;
+  } DeviceSpecific;
+} STORAGE_DEVICE_LAYOUT_SIGNATURE, *PSTORAGE_DEVICE_LAYOUT_SIGNATURE;
+
 /* Get ID string from STORAGE_DEVICE_DESCRIPTIOR. */
 static bool
 stordesc_to_id_name (const UNICODE_STRING *upath, char *ioctl_buf,
 		    char (& name)[NAME_MAX + 1])
 {
+  const STORAGE_DEVICE_UNIQUE_IDENTIFIER *id =
+    reinterpret_cast<const STORAGE_DEVICE_UNIQUE_IDENTIFIER *>(ioctl_buf);
+  char *desc_buf = ioctl_buf + id->StorageDeviceOffset;
   const STORAGE_DEVICE_DESCRIPTOR *desc =
-    reinterpret_cast<const STORAGE_DEVICE_DESCRIPTOR *>(ioctl_buf);
+    reinterpret_cast<const STORAGE_DEVICE_DESCRIPTOR *>(desc_buf);
+
   /* Ignore drive if information is missing, too short or too long. */
   int vendor_len = 0, product_len = 0, serial_len = 0;
   if (desc->VendorIdOffset)
-    vendor_len = sanitize_id_string (ioctl_buf + desc->VendorIdOffset);
+    vendor_len = sanitize_id_string (desc_buf + desc->VendorIdOffset);
   if (desc->ProductIdOffset)
-    product_len = sanitize_id_string (ioctl_buf + desc->ProductIdOffset);
+    product_len = sanitize_id_string (desc_buf + desc->ProductIdOffset);
   if (desc->SerialNumberOffset)
-    serial_len = sanitize_id_string (ioctl_buf + desc->SerialNumberOffset);
+    serial_len = sanitize_id_string (desc_buf + desc->SerialNumberOffset);
 
-  bool valid = (4 <= vendor_len + product_len && 4 <= serial_len
-		&& (20 + vendor_len + 1 + product_len + 1 + serial_len + 10)
+  bool valid = (4 <= vendor_len + product_len
+		&& (20 + vendor_len + 1 + product_len + 1 + 10)
 		   < (int) sizeof (name));
   debug_printf ("%S: '%s' '%s' '%s'%s", upath,
-		(vendor_len ? ioctl_buf + desc->VendorIdOffset : ""),
-		(product_len ? ioctl_buf + desc->ProductIdOffset : ""),
-		(serial_len ? ioctl_buf + desc->SerialNumberOffset : ""),
+		(vendor_len ? desc_buf + desc->VendorIdOffset : ""),
+		(product_len ? desc_buf + desc->ProductIdOffset : ""),
+		(serial_len ? desc_buf + desc->SerialNumberOffset : ""),
 		(valid ? "" : " (ignored)"));
   if (!valid)
     return false;
@@ -85,15 +107,24 @@ stordesc_to_id_name (const UNICODE_STRING *upath, char *ioctl_buf,
 
   /* Create "BUSTYPE-[VENDOR_]PRODUCT_SERIAL" string. */
   if (vendor_len)
-    strcat (name, ioctl_buf + desc->VendorIdOffset);
+    strcat (name, desc_buf + desc->VendorIdOffset);
   if (product_len)
     {
       if (vendor_len)
 	strcat (name, "_");
-      strcat (name, ioctl_buf + desc->ProductIdOffset);
+      strcat (name, desc_buf + desc->ProductIdOffset);
     }
   strcat (name, "_");
-  strcat (name, ioctl_buf + desc->SerialNumberOffset);
+  if (1) /* Utilize the DUID as defined by MSDN */
+    {
+      unsigned long hash = 0;
+
+      for (ULONG i = 0; i < id->Size; ++i)
+	hash = ioctl_buf[i] + (hash << 6) + (hash << 16) - hash;
+      __small_sprintf (name + strlen (name), "%X", hash);
+    }
+  else
+    strcat (name, desc_buf + desc->SerialNumberOffset);
   return true;
 }
 
@@ -212,7 +243,7 @@ get_by_id_table (by_id_entry * &table)
 	  /* Fetch vendor, product and serial number. */
 	  DWORD bytes_read;
 	  STORAGE_PROPERTY_QUERY query =
-	    { StorageDeviceProperty, PropertyStandardQuery, { 0 } };
+	    { StorageDeviceUniqueIdProperty, PropertyStandardQuery, { 0 } };
 	  if (!DeviceIoControl (devhdl, IOCTL_STORAGE_QUERY_PROPERTY,
 				&query, sizeof (query),
 				ioctl_buf, NT_MAX_PATH,
=============== SNAP ================

And, btw, rather than using strcpy/strcat, can you please utilize
stpcpy?  You just have to keep the pointer around and you can
concat w/o always having to go over the full length of the string.


Corinna
