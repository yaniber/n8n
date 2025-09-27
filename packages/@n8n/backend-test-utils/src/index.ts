import type { Logger } from '@n8n/backend-common';
import { mock, MockProxy } from 'jest-mock-extended';

export const mockLogger = (): MockProxy<Logger> & Logger => {
	const logger = mock<Logger>();
	const scopedLogger = mock<Logger>();
	// Remplacer mockReturnValue par un setup explicite de la fonction
	logger.scoped.mockImplementation(() => scopedLogger);
	return logger;
};

export * from './random';
export * as testDb from './test-db';
export * as testModules from './test-modules';
export * from './db/workflows';
export * from './db/projects';
export * from './mocking';
