Return-Path: <cygwin-patches-return-5936-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12598 invoked by alias); 20 Jul 2006 07:26:09 -0000
Received: (qmail 12587 invoked by uid 22791); 20 Jul 2006 07:26:08 -0000
X-Spam-Check-By: sourceware.org
Received: from natlemon.rzone.de (HELO natlemon.rzone.de) (81.169.145.170)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 20 Jul 2006 07:26:06 +0000
Received: from [192.168.0.11] (p5080CEDF.dip.t-dialin.net [80.128.206.223]) 	(authenticated bits=0) 	by post.webmailer.de (8.13.6/8.13.6) with ESMTP id k6K7Q15E018692 	for <cygwin-patches@cygwin.com>; Thu, 20 Jul 2006 09:26:02 +0200 (MEST)
Message-ID: <44BF3023.9060707@data-al.de>
Date: Thu, 20 Jul 2006 07:26:00 -0000
From: Silvio Laguzzi <slaguzzi@data-al.de>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: 1.5.20: Fix for parsing ACL entries with aclfromtext32() in sec_acl.cc
Content-Type: multipart/mixed;  boundary="------------070200090302070300080302"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q3/txt/msg00031.txt.bz2

This is a multi-part message in MIME format.
--------------070200090302070300080302
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 1360

Hi, all

when parsing ACL entries from an input string with aclfromtext32() the
ACL rights follow at different position after the ACL entry tags like 
default:user, user, group, mask and so on. For almost all of the tags 
this position was not handled correctly.


With the supplied patch you can now parse an input string with
char *
aclfromtext32(char *acltextp, int *aclcnt)
that holds abbreviated ACL entry tags like under SunOS.

I've taken the previously unused int * parameter of this function to 
return the number of correctly parsed ACL entries confirming to Sun's 
manpage.

Here's the new input format of acltextp buffer:

<acl_entry>[,<acl_entry>]*

where <acl_entry> can be either one of:

u[ser]:[id|username]:rwx
g[roup]:[id|groupname]:rwx
o[ther]::rwx
m[ask]::rwx

or one of the default ACL entries:
d[efault]:u[ser]:[id|username]:rwx
d[efault]:g[roup]:[id|groupname]:rwx
d[efault]:o[ther]::rwx
d[efault]:m[ask]::rwx


In acltotext32() I've added a colon between 'default' and the rest of an 
ACL entry type so that the output string has the same format like under 
SunOS and Linux.

Therefore default entry types are now exported as

default:user:[id]:rwx,
default:group:[id]:rwx,
default:mask::rwx,
default:other::rwx,


Best regards,

Silvio Laguzzi

---
Silvio Laguzzi
Zimmer-AL GmbH
Junkersstrasse 9
D-89231 Neu-Ulm
http://www.data-al.de

--------------070200090302070300080302
Content-Type: text/plain;
 name="sec_acl.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sec_acl.patch"
Content-length: 4032

--- sec_acl-orig.cc	2006-07-18 17:52:13.421875000 +0200
+++ sec_acl.cc	2006-07-20 09:20:27.562500000 +0200
@@ -727,7 +727,7 @@ acltotext32 (__aclent32_t *aclbufp, int 
 	strcat (buf, ",");
       first = false;
       if (aclbufp[pos].a_type & ACL_DEFAULT)
-	strcat (buf, "default");
+	strcat (buf, "default:");	/* use Sun and Linux compatible output format */
       switch (aclbufp[pos].a_type & ~ACL_DEFAULT)
 	{
 	case USER_OBJ:
@@ -785,11 +785,13 @@ permfromstr (char *perm)
 }
 
 extern "C" __aclent32_t *
-aclfromtext32 (char *acltextp, int *)
+aclfromtext32 (char *acltextp, int *aclcnt)
 {
+  /* parameter aclcnt returns the number of ACL entries found */
   if (!acltextp)
     {
       set_errno (EINVAL);
+      *aclcnt = 0;
       return NULL;
     }
   char buf[strlen (acltextp) + 1];
@@ -802,25 +804,29 @@ aclfromtext32 (char *acltextp, int *)
        c;
        c = strtok_r (NULL, ",", &lasts))
     {
-      if (!strncmp (c, "default", 7))
+      if (!strncmp(c, "d:", 2) || !strncmp(c, "default:", 8))
 	{
 	  lacl[pos].a_type |= ACL_DEFAULT;
-	  c += 7;
+	  c += (c[2] == ':') ? 3 : 8;
 	}
-      if (!strncmp (c, "user:", 5))
+      if (!strncmp(c, "u:", 2) || !strncmp (c, "user:", 5))
 	{
-	  if (c[5] == ':')
-	    lacl[pos].a_type |= USER_OBJ;
+	  if ((c[2] == ':') || (c[5] == ':'))
+	    {
+	      lacl[pos].a_type |= USER_OBJ;
+	      c += (c[2] == ':') ? 3 : 6;
+	    }
 	  else
 	    {
 	      lacl[pos].a_type |= USER;
-	      c += 5;
+	      c += (c[1] == ':') ? 2 : 5;
 	      if (isalpha (*c))
 		{
 		  struct passwd *pw = internal_getpwnam (c);
 		  if (!pw)
 		    {
 		      set_errno (EINVAL);
+		      *aclcnt = 0;
 		      return NULL;
 		    }
 		  lacl[pos].a_id = pw->pw_uid;
@@ -828,27 +834,32 @@ aclfromtext32 (char *acltextp, int *)
 		}
 	      else if (isdigit (*c))
 		lacl[pos].a_id = strtol (c, &c, 10);
-	      if (*c != ':')
+	      if (*c++ != ':')
 		{
 		  set_errno (EINVAL);
+		  *aclcnt = 0;
 		  return NULL;
 		}
 	    }
 	}
-      else if (!strncmp (c, "group:", 6))
+      else if (!strncmp (c, "g:", 2) || !strncmp (c, "group:", 6))
 	{
-	  if (c[5] == ':')
-	    lacl[pos].a_type |= GROUP_OBJ;
+	  if ((c[2] == ':') || (c[6] == ':'))
+	    {
+	      lacl[pos].a_type |= GROUP_OBJ;
+	      c += (c[2] == ':') ? 3 : 7;
+	    }
 	  else
 	    {
 	      lacl[pos].a_type |= GROUP;
-	      c += 5;
+	      c += (c[1] == ':') ? 2 : 6;
 	      if (isalpha (*c))
 		{
 		  struct __group32 *gr = internal_getgrnam (c);
 		  if (!gr)
 		    {
 		      set_errno (EINVAL);
+		      *aclcnt = 0;
 		      return NULL;
 		    }
 		  lacl[pos].a_id = gr->gr_gid;
@@ -856,40 +867,51 @@ aclfromtext32 (char *acltextp, int *)
 		}
 	      else if (isdigit (*c))
 		lacl[pos].a_id = strtol (c, &c, 10);
-	      if (*c != ':')
+	      if (*c++ != ':')
 		{
 		  set_errno (EINVAL);
+		  *aclcnt = 0;
 		  return NULL;
 		}
 	    }
 	}
-      else if (!strncmp (c, "mask:", 5))
+      else if (!strncmp (c, "m:", 2) || !strncmp (c, "mask:", 5))
 	{
-	  if (c[5] == ':')
-	    lacl[pos].a_type |= CLASS_OBJ;
+	  if ((c[2] == ':') || (c[5] == ':'))
+	    {
+	      lacl[pos].a_type |= CLASS_OBJ;
+	      c += (c[2] == ':') ? 3 : 6;
+	    }
 	  else
 	    {
 	      set_errno (EINVAL);
+	      *aclcnt = 0;
 	      return NULL;
 	    }
 	}
-      else if (!strncmp (c, "other:", 6))
+      else if (!strncmp (c, "o:", 2) || !strncmp (c, "other:", 6))
 	{
-	  if (c[5] == ':')
-	    lacl[pos].a_type |= OTHER_OBJ;
+	  if ((c[2] == ':') || (c[6] == ':'))
+	    {
+	      lacl[pos].a_type |= OTHER_OBJ;
+	      c += (c[2] == ':') ? 3 : 7;
+	    }
 	  else
 	    {
 	      set_errno (EINVAL);
+	      *aclcnt = 0;
 	      return NULL;
 	    }
 	}
       if ((lacl[pos].a_perm = permfromstr (c)) == 01000)
 	{
 	  set_errno (EINVAL);
+	  *aclcnt = 0;
 	  return NULL;
 	}
       ++pos;
     }
+  *aclcnt = pos;			/* set number of ACL entries */
   __aclent32_t *aclp = (__aclent32_t *) malloc (pos * sizeof (__aclent32_t));
   if (aclp)
     memcpy (aclp, lacl, pos * sizeof (__aclent32_t));

--------------070200090302070300080302
Content-Type: text/plain;
 name="ChangeLog"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ChangeLog"
Content-length: 342

2006-07-20  Silvio Laguzzi  <slaguzzi@data-al.de>

	* sec_acl.cc (acltotext32): Default ACL entry types now use the SUN
	and Linux compatible output format.
	(aclfromtext32): Adjust position on input string when parsing ACL
	entry types which can have abbreviated entry tags (cf. input format of
	entry tags for setfacl command under SunOS).

--------------070200090302070300080302--
