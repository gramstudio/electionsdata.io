import { prisma } from '../prisma';
import { z } from 'zod';
import { router, publicProcedure } from '../trpc';

const ElectionType = z.enum(['PRESIDENTIAL', 'PARLIAMENTARY']);

const ElectionQuery = z.object({
  countryName: z.string(),
  year: z.number().nullable(),
});

const ElectionResult = z.object({
  id: z.string().uuid(),
  electionId: z.string(),
  candidate: z.string().nullable(),
  party: z.string().nullable(),
  votes: z.number().int(),
  percentage: z.number().nullable(),
});

const ElectionOutput = z.object({
  id: z.string().uuid(),
  countryId: z.string(),
  date: z.date(),
  pollClose: z.date(),
  type: ElectionType,
  notes: z.string().nullable(),
  eta: z.string().nullable(),
  dataSource: z.string(),
  dataUrl: z.string(),
  results: z.array(ElectionResult).nullable(),
});

export const electionRouter = router({
  read: publicProcedure
    .input(ElectionQuery)
    .output(z.array(ElectionOutput))
    .query(async ({ input }) => {
      const country = await prisma.country.findUnique({
        where: { name: input.countryName },
        include: {
          elections: {
            where: {
              date: input.year
                ? {
                    gte: new Date(input.year, 0, 1),
                    lt: new Date(input.year + 1, 0, 1),
                  }
                : undefined,
            },
            include: {
              results: true,
            },
          },
        },
      });
      if (!country) throw new Error('Country not found');
      return country.elections;
    }),
});
