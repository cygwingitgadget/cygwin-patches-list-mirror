Return-Path: <cygwin-patches-return-3272-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8951 invoked by alias); 4 Dec 2002 09:45:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8896 invoked from network); 4 Dec 2002 09:45:10 -0000
From: "Craig McGeachie" <slapdau@yahoo.com.au>
To: cygwin-patches@cygwin.com
Date: Wed, 04 Dec 2002 01:45:00 -0000
MIME-Version: 1.0
Content-type: Multipart/Mixed; boundary=Message-Boundary-6440
Subject: Re: PATCH: Implementation of functions in netdb.h
Message-ID: <3DEE8558.6102.51AEB1@localhost>
Priority: normal
In-reply-to: <20021202171548.GA21064@redhat.com>
References: <3DDA4A99.16846.1EEFD0D0@localhost>
X-SW-Source: 2002-q4/txt/msg00223.txt.bz2


--Message-Boundary-6440
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Content-length: 1878

2002-11-19 Craig McGeachie <slapdau@yahoo.com.au>
 * netdb.cc (open_system_file, get_entire_line, get_alias_list)
 (open_services_file, parse_services_line, free_servent)
 (cygwin_setservent, cygwin_getservent, cygwin_endservent)
 (open_protocol_file, parse_protocol_line, free_protoent)
 (cygwin_setprotoent, cygwin_getprotoent, cygwin_endprotoent):
 New file.
 * Makeile.in (DLL_OFILES): Add reference to the new netdb.cc
 file.
 * cygwin.din : Add new aliased exports for service and
 protocol enumerations in netdb.cc.


On 2 Dec 2002 at 12:15, Christopher Faylor wrote:
> FYI, we've received your assignment.  Looking forward to a patch
> against CVS sources. 
> Btw, the copyright notice should only list the current year, 2002,
> for any new file. 

Ok.  Here is a patch, diffed against the current CVS sources.  Using 
cvs diff, I can't get the new file included in the diff file, the way I 
did last time so I attached it separately.

I changed the comments to be more useful than "cygwin internal" and 
added some calls to debug_printf, syscall_printf, and paranoid_printf 
where I thought appropiate.  I'm still not happy about the treatment of 
returns from malloc and strdup, where the code is simply assuming that 
valid memory will be returned.  I have at least put the paranoid_printf 
function calls in, but I want something better.  I thought that 
set_errno might be the way to go, but I can't see that that this is the 
right solution.  Should I call set_errno, and return null values?  
Incidentally I function one function that terminated the running 
process with an error code if the call to malloc failed.


----------------+-------------------------------------------------
Craig McGeachie | #include <cheesy_tag.h>
+64(21)037-6917 | while (!inebriated) c2h5oh=(++bottle)->contents;
----------------+-------------------------------------------------



--Message-Boundary-6440
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Text from file 'netdb.diff'
Content-length: 1536

? winsup/cygwin/netdb.cc
Index: winsup/cygwin/Makefile.in
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/Makefile.in,v
retrieving revision 1.108
diff -u -p -r1.108 Makefile.in
--- winsup/cygwin/Makefile.in	20 Oct 2002 04:15:49 -0000	1.108
+++ winsup/cygwin/Makefile.in	4 Dec 2002 09:25:45 -0000
@@ -137,7 +137,7 @@ DLL_OFILES:=assert.o autoload.o cygheap.
 	fhandler_tty.o fhandler_virtual.o fhandler_windows.o \
 	fhandler_zero.o fnmatch.o fork.o glob.o grp.o heap.o init.o \
 	ioctl.o ipc.o localtime.o malloc.o malloc_wrapper.o \
-	miscfuncs.o mmap.o msg.o net.o ntea.o passwd.o path.o pinfo.o \
+	miscfuncs.o mmap.o msg.o net.o netdb.o ntea.o passwd.o path.o pinfo.o \
 	pipe.o poll.o pthread.o regcomp.o regerror.o regexec.o \
 	regfree.o registry.o resource.o scandir.o sched.o sec_acl.o \
 	sec_helper.o security.o select.o sem.o shared.o shm.o signal.o \
Index: winsup/cygwin/cygwin.din
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/cygwin.din,v
retrieving revision 1.70
diff -u -p -r1.70 cygwin.din
--- winsup/cygwin/cygwin.din	27 Nov 2002 16:11:38 -0000	1.70
+++ winsup/cygwin/cygwin.din	4 Dec 2002 09:25:51 -0000
@@ -1308,3 +1308,9 @@ acltotext
 _acltotext = acltotext
 aclfromtext
 _aclfromtext = aclfromtext
+setprotoent = cygwin_setprotoent
+setservent = cygwin_setservent
+getservent = cygwin_getservent
+getprotoent = cygwin_getprotoent
+endprotoent = cygwin_endprotoent
+endservent = cygwin_endservent

--Message-Boundary-6440
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Text from file 'netdb.cc'
Content-length: 11384

/* netdb.cc: network database related routines.

   Copyright 2002 Red Hat, Inc.

This file is part of Cygwin.

This software is a copyrighted work licensed under the terms of the
Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
details. */

#include "winsup.h"
#include <windows.h>
#include <sys/cygwin.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <netdb.h>

/* Locate and open a system network database file.  relative_path
 should be one of the following values:
 "protocol"
 "services"
 "networks"
 "hosts"

 This routine will try to locate these files based on system type.
 Currently the only distinction made is between NT and non-NT systems.

 It is the callers responsibility to close the file.
*/
static FILE *
open_system_file (const char *relative_path)
{
  char win32_name[MAX_PATH];
  char posix_name[MAX_PATH];
  if (wincap.is_winnt())
    {
      if (! GetSystemDirectory (win32_name, MAX_PATH) ) return NULL;
      strcat (win32_name, "\\drivers\\etc\\");
    }
  else
    {
      if (! GetWindowsDirectory (win32_name, MAX_PATH) ) return NULL;
      strcat (win32_name, "\\");
    }
  strcat (win32_name, relative_path);
  cygwin_conv_to_full_posix_path (win32_name, posix_name);
  debug_printf("netdb file to open %s", win32_name);
  FILE *result = fopen (posix_name, "rt");
  debug_printf("handle to netdb file %p", result);
  return result;
}

/* Read an entire line up till the next \n character.  Memory for the
line is dynamically allocated, and the caller must call free() to
deallocate it.  When the end of file is reached, NULL is returned.
*/
static char *
get_entire_line (FILE *fd)
{
  static const int BUFF_SIZE = 1024;
  struct line_fragment {
    char buffer[BUFF_SIZE];
    line_fragment *next;
  };
  line_fragment *fragment_list_head = NULL;
  line_fragment *fragment = NULL;
  int fragment_count = 0;
  char *result;
  do
    {
      line_fragment *new_fragment = (line_fragment *) malloc (sizeof (line_fragment));
      paranoid_printf("line fragment allocated %p", new_fragment);
      if (! fragment_list_head) fragment_list_head = new_fragment;
      if (fragment) fragment->next = new_fragment;
      fragment = new_fragment;
      fragment->next = NULL;
      *fragment->buffer = '\0';
      result = fgets (fragment->buffer, BUFF_SIZE, fd);
      ++fragment_count;
    }
  while (result && !strchr (fragment->buffer, '\n'));
  if (*fragment_list_head->buffer != '\0')
    {
      char *concatenated_line = (char *) calloc (fragment_count * BUFF_SIZE , sizeof(char));
      paranoid_printf("concatenated line allocated %p", concatenated_line);
      *concatenated_line = '\0';
      fragment = fragment_list_head;
      while (fragment != NULL)
        {
          line_fragment *previous = fragment;
          strcat(concatenated_line, fragment->buffer);
          fragment = fragment->next;
          free(previous);
        }
      return concatenated_line;
    }
  else
    {
      fragment = fragment_list_head;
      while (fragment != NULL)
        {
          line_fragment *previous = fragment;
          fragment = fragment->next;
          free(previous);
        }
      return NULL;
    }
}

/* Characters representing whitespace.  Used by parse_* routines to
delimit tokens.  */
static const char *SPACE = " \t\n\r\f";

/* Parse a list aliases from a network database file.  Returns a
char** structure terminated by a NULL.

N.B. This routine relies on side effects due to the nature of
strtok().  strtok() initially takes a char * pointing to the start of
a line, and then NULL to indicate continued processing.  strtok() does
not provide a mechanism for getting pointer to the unprocessed portion
of a line.  Alias processing is done part way through a line after
strtok().  This routine relies on further calls to strtok(), passing
NULL as the first parameter, returning alias names from the line. */
static void
parse_alias_list(char ***aliases)
{ 
  struct alias_t {
    char *alias_name;
    alias_t *next;
  };
  alias_t *alias_list_head = NULL, *alias_list_tail = NULL;
  char *alias;
  int alias_count = 0;
  alias = strtok(NULL, SPACE);
  while (alias)
    {
      ++alias_count;
      alias_t *new_alias = (alias_t *) malloc (sizeof (alias_t));
      paranoid_printf("new alias alloc %p", new_alias);
      if (!alias_list_head) alias_list_head = new_alias;
      if (alias_list_tail) alias_list_tail->next = new_alias;
      new_alias->next = NULL;
      new_alias->alias_name = alias;
      alias_list_tail = new_alias;
      alias = strtok(NULL, SPACE);
    }
  *aliases = (char**) calloc (alias_count + 1, sizeof(char *));
  paranoid_printf("aliases alloc %p", *aliases);
  char **current_entry = *aliases;
  while (alias_list_head)
    {
      alias_t *previous = alias_list_head;
      *current_entry = strdup (alias_list_head->alias_name);
      paranoid_printf("*current entry strdup %p", *current_entry);
      alias_list_head = alias_list_head->next;
      free (previous);
      ++current_entry;
    }
  *current_entry = NULL;
}

/* Wrapper for open_system_file(), fixing the constant name
"services".  Returns the open file. */
static FILE *
open_services_file ()
{
  return open_system_file ("services");
}

/* Read the next line from svc_file, and parse it into the structure
pointed to by sep.  sep can point to stack or static data, but it's
members will be overwritten with pointers to dynamically allocated
heap data accommodating parsed data.  It is the responsibility of the
caller to free up the allocated structures. The function returns true
to indicate that a line was successfully read and parsed.  False is
used to indicate that no more lines can be read and parsed.  This
should also interpreted as end of file. */
static bool
parse_services_line (FILE *svc_file, struct servent *sep)
{
  char *line;
  while ((line = get_entire_line (svc_file)))
    {
      char *name, *port, *protocol;
      
      line[strcspn (line, "#")] = '\0'; // truncate at comment marker.
      name = strtok(line, SPACE);
      if (!name)
        {
          free(line);
          continue;
        }
      port = strtok(NULL, SPACE);
      protocol = strchr(port, '/');
      *protocol++ = '\0';
      sep->s_name = strdup (name);
      paranoid_printf("sep->s_name strdup %p", sep->s_name);
      sep->s_port = atoi (port);
      sep->s_proto = strdup (protocol);
      paranoid_printf("sep->s_proto strdup %p", sep->s_proto);
      /* parse_alias_list relies on side effects.  Read the comments
         for that function.*/
      parse_alias_list(& sep->s_aliases);
      free (line);
      return true;
    }
  return false;
}

static FILE *svc_file = NULL;
static long int svc_read_pos = 0;
static struct servent current_servent;

/* Steps through a struct servent, and frees all of the internal
structures.*/
static void
free_servent (struct servent *sep)
{
  free (sep->s_name);
  free (sep->s_proto);
  char ** current = sep->s_aliases;
  while (current && *current)
    {
      free (*current);
      ++current;
    }
  free (sep->s_aliases);
  sep->s_name = NULL;
  sep->s_port = 0;
  sep->s_proto = NULL;
  sep->s_aliases = NULL;
}

extern "C" void
cygwin_setservent (int stay_open)
{
  if (svc_file)
    {
      fclose (svc_file);
    }
  if (stay_open)
    {
      svc_file = open_services_file ();
    }
  free_servent (&current_servent);
  svc_read_pos = 0;
  syscall_printf ("setservent (%d)", stay_open);
}

extern "C" struct servent *
cygwin_getservent (void)
{
  FILE *fd;
  if (svc_file)
    {
      fd = svc_file;
    }
  else
    {
      fd = open_services_file ();
      if (!fd)
        {
          syscall_printf ("%p = getservent()", NULL);
          return NULL;
        }
      fseek (fd, svc_read_pos, SEEK_SET);
    }
  free_servent (&current_servent);
  bool found = parse_services_line (fd, &current_servent);
  if (!svc_file)
    {
      svc_read_pos = ftell(fd);
      fclose(fd);
    }
  struct servent *result;
  if (found)
    {
      result = &current_servent;
    }
  else
    {
      result = NULL;
    }
  syscall_printf ("%p = getservent()", result);
  return result;
}

extern "C" void
cygwin_endservent (void)
{
  if (svc_file)
    {
      fclose (svc_file);
      svc_file = NULL;
    }
  free_servent (&current_servent);
  svc_read_pos = 0;
  syscall_printf ("endservent ()");
}

static FILE *
open_protocol_file ()
{
  return open_system_file ("protocol");
}

/* Read the next line from proto_file, and parse it into the structure
pointed to by pep.  pep can point to stack or static data, but it's
members will be overwritten with pointers to dynamically allocated
heap data accommodating parsed data.  It is the responsibility of the
caller to free up the allocated structures. The function returns true
to indicate that a line was successfully read and parsed.  False is
used to indicate that no more lines can be read and parsed.  This
should also interpreted as end of file. */
static bool
parse_protocol_line (FILE *proto_file, struct protoent *pep)
{
  char *line;
  while ((line = get_entire_line (proto_file)))
    {
      char *name, *protocol;
      
      line[strcspn (line, "#")] = '\0'; // truncate at comment marker.
      name = strtok(line, SPACE);
      if (!name)
        {
          free(line);
          continue;
        }
      protocol = strtok(NULL, SPACE);
      pep->p_name = strdup (name);
      paranoid_printf("pep->p_name strdup %p", pep->p_name);
      pep->p_proto = atoi (protocol);
      /* parse_alias_list relies on side effects.  Read the comments
         for that function.*/
      parse_alias_list(& pep->p_aliases);
      free (line);
      return true;
    }
  return false;
}

static FILE *proto_file = NULL;
static long int proto_read_pos = 0;
static struct protoent current_protoent;

/* Steps through a struct protoent, and frees all the internal
structures.  */
static void
free_protoent (struct protoent *pep)
{
  free (pep->p_name);
  char ** current = pep->p_aliases;
  while (current && *current)
    {
      free (*current);
      ++current;
    }
  free (pep->p_aliases);
  pep->p_name = NULL;
  pep->p_proto = 0;
  pep->p_aliases = NULL;
}

extern "C" void
cygwin_setprotoent (int stay_open)
{
  if (proto_file)
    {
      fclose (proto_file);
    }
  if (stay_open)
    {
      proto_file = open_protocol_file ();
    }
  free_protoent (&current_protoent);
  proto_read_pos = 0;
  syscall_printf ("setprotoent (%d)", stay_open);
}

extern "C" struct protoent *
cygwin_getprotoent (void)
{
  FILE *fd;
  if (proto_file)
    {
      fd = proto_file;
    }
  else
    {
      fd = open_protocol_file ();
      if (!fd)
        {
          syscall_printf ("%p = getprotoent()", NULL);
          return NULL;
        }
      fseek (fd, proto_read_pos, SEEK_SET);
    }
  free_protoent (&current_protoent);
  bool found = parse_protocol_line (fd, &current_protoent);
  if (!proto_file)
    {
      proto_read_pos = ftell(fd);
      fclose(fd);
    }
  struct protoent *result;
  if (found)
    {
      result =  &current_protoent;
    }
  else
    {
      result =  NULL;
    }
  syscall_printf ("%p = getprotoent()", result);
  return result;
}

extern "C" void
cygwin_endprotoent (void)
{
  if (proto_file)
    {
      fclose (proto_file);
      proto_file = NULL;
    }
  free_protoent (&current_protoent);
  proto_read_pos = 0;
  syscall_printf ("endprotoent ()");
}

--Message-Boundary-6440--
