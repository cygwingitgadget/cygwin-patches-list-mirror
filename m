Return-Path: <cygwin-patches-return-3202-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21508 invoked by alias); 18 Nov 2002 21:26:27 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21494 invoked from network); 18 Nov 2002 21:26:25 -0000
From: "Craig McGeachie" <slapdau@yahoo.com.au>
To: cygwin-patches@cygwin.com
Date: Mon, 18 Nov 2002 13:26:00 -0000
MIME-Version: 1.0
Content-type: Multipart/Mixed; boundary=Message-Boundary-3613
Subject: PATCH: Implementation of functions in netdb.h
Message-ID: <3DDA11BD.5862.1E11B85E@localhost>
Priority: normal
X-SW-Source: 2002-q4/txt/msg00153.txt.bz2


--Message-Boundary-3613
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Content-length: 1968

This is an implementation of [set|get|end][serv|proto]ent functions as
defined in netdb.h.  It was written primarily so I could port the DHCP
software from ISC to Cygwin.

Firstly, this is a larger than trivial submission, I suppose I will 
have fill in a standard assignment form.  However, I thought I post 
this first to see if I'm on the right track.

This has been coded against the 1.3.14-1 sources.  That's what was 
available when I started, and I can't read the CVS repository directly.

I only have the W2K machine to work and test on.  Consequently I can't 
be
sure that the Win95/98/ME path names for the protocol and services 
files
are correct and work.  If they aren't, then the files will not be 
opened,
and all calls to get[serv|proto]ent will return NULL. the set and end
functions will quietly do nothing.

I have implemented all the functions in a new file called netdb.cc.  I
wasn't sure if I should add the new file, or add functions to net.cc.  
I
went for the new file, in the expectation that I would add get|set|end
functions for the hosts and networks files and some stage in the 
future.

2002-11-19 Craig McGeachie <slapdau@yahoo.com.au>
 * netdb.cc (open_system_file, get_entire_line, get_alias_list)
 (open_services_file, parse_services_line, free_servent)
 (cygwin_setservent, cygwin_getservent, cygwin_endservent)
 (open_protocol_file, parse_protocol_line, free_protoent)
 (cygwin_setprotoent, cygwin_getprotoent, cygwin_endprotoent):
 Create a new file implementing the service and protocol
 enumeration functions in netdb.h.
 * Makeile.in (DLL_OFILES): Add reference to the new netdb.cc
 file.
 * cygwin.din : Add new aliased exports for service and
 protocol enumerations in netdb.cc.

----------------+-------------------------------------------------
Craig McGeachie | #include <cheesy_tag.h>
+64(21)037-6917 | while (!inebriated) c2h5oh=(++bottle)->contents;
----------------+-------------------------------------------------



--Message-Boundary-3613
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Text from file 'netdb.patch'
Content-length: 9666

diff -uprN ../../cygwin-1.3.14-1-orig/winsup/cygwin/Makefile.in ./cygwin/Makefile.in
--- ../../cygwin-1.3.14-1-orig/winsup/cygwin/Makefile.in	2002-10-21 14:03:32.000000000 +1300
+++ ./cygwin/Makefile.in	2002-11-18 23:39:35.000000000 +1300
@@ -137,7 +137,7 @@ DLL_OFILES:=assert.o autoload.o cygheap.
 	fhandler_tty.o fhandler_virtual.o fhandler_windows.o \
 	fhandler_zero.o fnmatch.o fork.o glob.o grp.o heap.o init.o \
 	ioctl.o ipc.o localtime.o malloc.o malloc_wrapper.o \
-	miscfuncs.o mmap.o msg.o net.o ntea.o passwd.o path.o pinfo.o \
+	miscfuncs.o mmap.o msg.o net.o netdb.o ntea.o passwd.o path.o pinfo.o \
 	pipe.o poll.o pthread.o regcomp.o regerror.o regexec.o \
 	regfree.o registry.o resource.o scandir.o sched.o sec_acl.o \
 	sec_helper.o security.o select.o sem.o shared.o shm.o signal.o \
diff -uprN ../../cygwin-1.3.14-1-orig/winsup/cygwin/cygwin.din ./cygwin/cygwin.din
--- ../../cygwin-1.3.14-1-orig/winsup/cygwin/cygwin.din	2002-10-21 14:03:32.000000000 +1300
+++ ./cygwin/cygwin.din	2002-11-19 08:49:16.000000000 +1300
@@ -1297,3 +1297,9 @@ acltotext
 _acltotext = acltotext
 aclfromtext
 _aclfromtext = aclfromtext
+setprotoent = cygwin_setprotoent
+setservent = cygwin_setservent
+getservent = cygwin_getservent
+getprotoent = cygwin_getprotoent
+endprotoent = cygwin_endprotoent
+endservent = cygwin_endservent
diff -uprN ../../cygwin-1.3.14-1-orig/winsup/cygwin/netdb.cc ./cygwin/netdb.cc
--- ../../cygwin-1.3.14-1-orig/winsup/cygwin/netdb.cc	1970-01-01 12:00:00.000000000 +1200
+++ ./cygwin/netdb.cc	2002-11-19 09:30:37.000000000 +1300
@@ -0,0 +1,357 @@
+/* netdb.cc: network database related routines.
+
+   Copyright 1996, 1997, 1998, 1999, 2000, 2001, 2002 Red Hat, Inc.
+
+This file is part of Cygwin.
+
+This software is a copyrighted work licensed under the terms of the
+Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
+details. */
+
+#include "winsup.h"
+#include <windows.h>
+#include <sys/cygwin.h>
+#include <stdio.h>
+#include <string.h>
+#include <stdlib.h>
+#include <netdb.h>
+
+/* Cygwin internal */
+static FILE *
+open_system_file (const char *relative_path)
+{
+  char win32_name[MAX_PATH];
+  char posix_name[MAX_PATH];
+  if (wincap.is_winnt())
+    {
+      if (! GetSystemDirectory (win32_name, MAX_PATH) ) return NULL;
+      strcat (win32_name, "\\drivers\\etc\\");
+    }
+  else
+    {
+      if (! GetWindowsDirectory (win32_name, MAX_PATH) ) return NULL;
+      strcat (win32_name, "\\");
+    }
+  strcat (win32_name, relative_path);
+  cygwin_conv_to_full_posix_path (win32_name, posix_name);
+  return fopen (posix_name, "r");
+}
+
+/* Cygwin internal */
+static char *
+get_entire_line (FILE *fd)
+{
+  static const int BUFF_SIZE = 1024;
+  struct line_fragment {
+    char buffer[BUFF_SIZE];
+    line_fragment *next;
+  };
+  line_fragment *fragment_list_head = NULL;
+  line_fragment *fragment = NULL;
+  int fragment_count = 0;
+  char *result;
+  do
+    {
+      line_fragment *new_fragment = (line_fragment *) malloc (sizeof (line_fragment));
+      if (! fragment_list_head) fragment_list_head = new_fragment;
+      if (fragment) fragment->next = new_fragment;
+      fragment = new_fragment;
+      fragment->next = NULL;
+      *fragment->buffer = '\0';
+      result = fgets (fragment->buffer, BUFF_SIZE, fd);
+      ++fragment_count;
+    }
+  while (result && !strchr (fragment->buffer, '\n'));
+  if (*fragment_list_head->buffer != '\0')
+    {
+      char *concatenated_line = (char *) calloc (fragment_count * BUFF_SIZE , sizeof(char));
+      *concatenated_line = '\0';
+      fragment = fragment_list_head;
+      while (fragment != NULL)
+        {
+          line_fragment *previous = fragment;
+          strcat(concatenated_line, fragment->buffer);
+          fragment = fragment->next;
+          free(previous);
+        }
+      return concatenated_line;
+    }
+  else
+    {
+      fragment = fragment_list_head;
+      while (fragment != NULL)
+        {
+          line_fragment *previous = fragment;
+          fragment = fragment->next;
+          free(previous);
+        }
+      return NULL;
+    }
+}
+
+static const char *SPACE = " \t\n\r\f";
+
+/* Cygwin internal */
+static void
+get_alias_list(char ***aliases)
+{ 
+  struct alias_t {
+    char *alias_name;
+    alias_t *next;
+  };
+  alias_t *alias_list_head = NULL, *alias_list_tail = NULL;
+  char *alias;
+  int alias_count = 0;
+  alias = strtok(NULL, SPACE);
+  while (alias)
+    {
+      ++alias_count;
+      alias_t *new_alias = (alias_t *) malloc (sizeof (alias_t));
+      if (!alias_list_head) alias_list_head = new_alias;
+      if (alias_list_tail) alias_list_tail->next = new_alias;
+      new_alias->next = NULL;
+      new_alias->alias_name = alias;
+      alias_list_tail = new_alias;
+      alias = strtok(NULL, SPACE);
+    }
+  *aliases = (char**) calloc (alias_count + 1, sizeof(char *));
+  char **current_entry = *aliases;
+  while (alias_list_head)
+    {
+      alias_t *previous = alias_list_head;
+      *current_entry = strdup (alias_list_head->alias_name);
+      alias_list_head = alias_list_head->next;
+      free (previous);
+      ++current_entry;
+    }
+  *current_entry = NULL;
+}
+
+/* Cygwin internal */
+static FILE *
+open_services_file ()
+{
+  return open_system_file ("services");
+}
+
+/* Cygwin internal */
+static bool
+parse_services_line (FILE *svc_file, struct servent *sep)
+{
+  char *line;
+  while ((line = get_entire_line (svc_file)))
+    {
+      char *name, *port, *protocol;
+      
+      line[strcspn (line, "#")] = '\0'; // truncate at comment marker.
+      name = strtok(line, SPACE);
+      if (!name)
+        {
+          free(line);
+          continue;
+        }
+      port = strtok(NULL, SPACE);
+      protocol = strchr(port, '/');
+      *protocol++ = '\0';
+      sep->s_name = strdup (name);
+      sep->s_port = atoi (port);
+      sep->s_proto = strdup (protocol);
+      get_alias_list(& sep->s_aliases);
+      free (line);
+      return true;
+    }
+  return false;
+}
+
+static FILE *svc_file = NULL;
+static long int svc_read_pos = 0;
+static struct servent current_servent;
+
+/* Cygwin internal */
+static void
+free_servent (struct servent *sep)
+{
+  free (sep->s_name);
+  free (sep->s_proto);
+  char ** current = sep->s_aliases;
+  while (current && *current)
+    {
+      free (*current);
+      ++current;
+    }
+  free (sep->s_aliases);
+  sep->s_name = NULL;
+  sep->s_port = 0;
+  sep->s_proto = NULL;
+  sep->s_aliases = NULL;
+}
+
+extern "C" void
+cygwin_setservent (int stay_open)
+{
+  if (svc_file)
+    {
+      fclose (svc_file);
+    }
+  if (stay_open)
+    {
+      svc_file = open_services_file ();
+    }
+  free_servent (&current_servent);
+  svc_read_pos = 0;
+}
+
+extern "C" struct servent *
+cygwin_getservent (void)
+{
+  FILE *fd;
+  if (svc_file)
+    {
+      fd = svc_file;
+    }
+  else
+    {
+      fd = open_services_file ();
+      if (!fd) return NULL;
+      fseek (fd, svc_read_pos, SEEK_SET);
+    }
+  free_servent (&current_servent);
+  bool found = parse_services_line (fd, &current_servent);
+  if (!svc_file)
+    {
+      svc_read_pos = ftell(fd);
+      fclose(fd);
+    }
+  if (found)
+    {
+      return &current_servent;
+    }
+  else
+    {
+      return NULL;
+    }
+}
+
+extern "C" void
+cygwin_endservent (void)
+{
+  if (svc_file)
+    {
+      fclose (svc_file);
+      svc_file = NULL;
+    }
+  free_servent (&current_servent);
+  svc_read_pos = 0;  
+}
+
+/* Cygwin internal */
+static FILE *
+open_protocol_file ()
+{
+  return open_system_file ("protocol");
+}
+
+/* Cygwin internal */
+static bool
+parse_protocol_line (FILE *proto_file, struct protoent *pep)
+{
+  char *line;
+  while ((line = get_entire_line (proto_file)))
+    {
+      char *name, *protocol;
+      
+      line[strcspn (line, "#")] = '\0'; // truncate at comment marker.
+      name = strtok(line, SPACE);
+      if (!name)
+        {
+          free(line);
+          continue;
+        }
+      protocol = strtok(NULL, SPACE);
+      pep->p_name = strdup (name);
+      pep->p_proto = atoi (protocol);
+      get_alias_list(& pep->p_aliases);
+      free (line);
+      return true;
+    }
+  return false;
+}
+
+static FILE *proto_file = NULL;
+static long int proto_read_pos = 0;
+static struct protoent current_protoent;
+
+/* Cygwin internal */
+static void
+free_protoent (struct protoent *pep)
+{
+  free (pep->p_name);
+  char ** current = pep->p_aliases;
+  while (current && *current)
+    {
+      free (*current);
+      ++current;
+    }
+  free (pep->p_aliases);
+  pep->p_name = NULL;
+  pep->p_proto = 0;
+  pep->p_aliases = NULL;
+}
+
+extern "C" void
+cygwin_setprotoent (int stay_open)
+{
+  if (proto_file)
+    {
+      fclose (proto_file);
+    }
+  if (stay_open)
+    {
+      proto_file = open_protocol_file ();
+    }
+  free_protoent (&current_protoent);
+  proto_read_pos = 0;
+}
+
+extern "C" struct protoent *
+cygwin_getprotoent (void)
+{
+  FILE *fd;
+  if (proto_file)
+    {
+      fd = proto_file;
+    }
+  else
+    {
+      fd = open_protocol_file ();
+      if (!fd) return NULL;
+      fseek (fd, proto_read_pos, SEEK_SET);
+    }
+  free_protoent (&current_protoent);
+  bool found = parse_protocol_line (fd, &current_protoent);
+  if (!proto_file)
+    {
+      proto_read_pos = ftell(fd);
+      fclose(fd);
+    }
+  if (found)
+    {
+      return &current_protoent;
+    }
+  else
+    {
+      return NULL;
+    }
+}
+
+extern "C" void
+cygwin_endprotoent (void)
+{
+  if (proto_file)
+    {
+      fclose (proto_file);
+      proto_file = NULL;
+    }
+  free_protoent (&current_protoent);
+  proto_read_pos = 0;  
+}

--Message-Boundary-3613--
